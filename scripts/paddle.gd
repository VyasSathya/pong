extends CharacterBody3D

@export var player_id: int = 1  ## 1 or 2
@export var speed: float = 10.0
var arena_half_height: float = 5.0

var up_action: String
var down_action: String


func _ready() -> void:
	up_action = "p%d_up" % player_id
	down_action = "p%d_down" % player_id
	add_to_group("paddle")


func setup(config: GameConfig) -> void:
	speed = config.paddle_speed
	arena_half_height = config.arena_height / 2.0 - 1.5  # minus paddle half-height


func _physics_process(delta: float) -> void:
	var input_dir := 0.0
	if Input.is_action_pressed(up_action):
		input_dir -= 1.0
	if Input.is_action_pressed(down_action):
		input_dir += 1.0

	velocity = Vector3(0, 0, input_dir * speed)
	move_and_slide()

	# Clamp to arena bounds
	position.z = clampf(position.z, -arena_half_height, arena_half_height)
