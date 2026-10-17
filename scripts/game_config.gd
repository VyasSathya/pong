class_name GameConfig
extends Resource

## Designer-configurable pong settings

@export_group("Ball Settings")
@export var num_balls_per_round: int = 1
@export var ball_speed_initial: float = 12.0
@export var ball_speed_up_frequency: float = 5.0  ## seconds between speed increases
@export var ball_speed_increment: float = 1.5

@export_group("Paddle Settings")
@export var paddle_speed: float = 10.0

@export_group("Win Condition")
@export var points_to_win: int = 5

@export_group("Arena")
@export var arena_width: float = 20.0  ## X axis total
@export var arena_height: float = 12.0  ## Z axis total
