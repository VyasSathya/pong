extends Node3D

## Main game controller

@export var config: GameConfig

var score_left: int = 0
var score_right: int = 0
var team_left: String = "Player 1"
var team_right: String = "Player 2"
var round_active := false
var game_over := false

@onready var paddle_left: CharacterBody3D = $PaddleLeft
@onready var paddle_right: CharacterBody3D = $PaddleRight
@onready var hud: Control = $HUD
@onready var ball_scene: PackedScene = preload("res://scenes/ball.tscn")
@onready var ball_container: Node3D = $Balls
@onready var countdown_label: Label = $HUD/CountdownLabel
@onready var center_label: Label = $HUD/CenterLabel

var balls: Array[CharacterBody3D] = []


func _ready() -> void:
	if config == null:
		config = GameConfig.new()

	# Get team names from autoload if available
	if GameState.team_left != "":
		team_left = GameState.team_left
	if GameState.team_right != "":
		team_right = GameState.team_right

	paddle_left.setup(config)
	paddle_right.setup(config)

	_update_hud()
	_start_round()


func _start_round() -> void:
	if game_over:
		return
	round_active = false
	center_label.text = "SPACE to serve"
	center_label.visible = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_start"):
		if not round_active and not game_over:
			_serve()
		elif game_over:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _serve() -> void:
	center_label.visible = false
	round_active = true

	# Spawn balls
	for i in config.num_balls_per_round:
		var ball = ball_scene.instantiate()
		ball_container.add_child(ball)
		ball.setup(config)
		ball.scored.connect(_on_ball_scored)
		ball.launch()
		balls.append(ball)


func _on_ball_scored(side: String) -> void:
	if side == "left":
		score_left += 1
	else:
		score_right += 1

	_update_hud()

	# Check for all balls inactive
	var any_active := false
	for ball in balls:
		if ball.active:
			any_active = true
			break

	if not any_active:
		_clear_balls()
		_check_win()


func _clear_balls() -> void:
	for ball in balls:
		ball.queue_free()
	balls.clear()


func _check_win() -> void:
	if score_left >= config.points_to_win:
		_game_over(team_left)
	elif score_right >= config.points_to_win:
		_game_over(team_right)
	else:
		_start_round()


func _game_over(winner: String) -> void:
	game_over = true
	round_active = false

	# Switch to score screen
	GameState.winner = winner
	GameState.final_score_left = score_left
	GameState.final_score_right = score_right
	GameState.team_left = team_left
	GameState.team_right = team_right
	get_tree().change_scene_to_file("res://scenes/score_screen.tscn")


func _update_hud() -> void:
	hud.get_node("LeftName").text = team_left
	hud.get_node("RightName").text = team_right
	hud.get_node("LeftScore").text = str(score_left)
	hud.get_node("RightScore").text = str(score_right)
	hud.get_node("WinTarget").text = "First to %d" % config.points_to_win
