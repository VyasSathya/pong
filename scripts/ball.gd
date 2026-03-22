extends CharacterBody3D

signal scored(side: String)

var direction := Vector3.ZERO
var current_speed: float = 12.0
var base_speed: float = 12.0
var speed_increment: float = 1.5
var speed_up_timer: float = 0.0
var speed_up_frequency: float = 5.0
var active := false

@onready var mesh: MeshInstance3D = $MeshInstance3D


func setup(config: GameConfig) -> void:
	base_speed = config.ball_speed_initial
	current_speed = base_speed
	speed_increment = config.ball_speed_increment
	speed_up_frequency = config.ball_speed_up_frequency


func launch() -> void:
	var angle = randf_range(-PI / 4.0, PI / 4.0)
	var side = 1.0 if randi() % 2 == 0 else -1.0
	direction = Vector3(cos(angle) * side, 0, sin(angle)).normalized()
	current_speed = base_speed
	speed_up_timer = 0.0
	active = true


func reset_position() -> void:
	position = Vector3.ZERO
	direction = Vector3.ZERO
	current_speed = base_speed
	speed_up_timer = 0.0
	active = false


func _physics_process(delta: float) -> void:
	if not active:
		return

	# Speed up over time
	speed_up_timer += delta
	if speed_up_timer >= speed_up_frequency:
		speed_up_timer -= speed_up_frequency
		current_speed += speed_increment

	velocity = direction * current_speed
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()

		if collider.is_in_group("paddle"):
			# Reflect with angle based on hit position
			var paddle_pos = collider.global_position.z
			var hit_pos = global_position.z
			var paddle_half = 1.5  # half paddle height
			var offset = (hit_pos - paddle_pos) / paddle_half
			offset = clampf(offset, -0.8, 0.8)

			var side_dir = sign(direction.x)
			direction = Vector3(-side_dir, 0, offset).normalized()
			# Nudge away from paddle to prevent sticking
			global_position += normal * 0.05

		elif collider.is_in_group("wall"):
			direction = direction.bounce(normal)
			global_position += normal * 0.05

	# Check scoring (past paddles)
	var half_width = 11.0
	if global_position.x < -half_width:
		scored.emit("right")
		reset_position()
	elif global_position.x > half_width:
		scored.emit("left")
		reset_position()
