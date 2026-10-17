extends Node

## Autoload singleton for passing data between scenes

var team_left: String = "Player 1"
var team_right: String = "Player 2"
var winner: String = ""
var final_score_left: int = 0
var final_score_right: int = 0

# Keybind overrides (scancode values, 0 = use default)
var p1_up_key: int = 0
var p1_down_key: int = 0
var p2_up_key: int = 0
var p2_down_key: int = 0
