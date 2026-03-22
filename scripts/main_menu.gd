extends Control

@onready var team1_input: LineEdit = $VBoxContainer/Team1Input
@onready var team2_input: LineEdit = $VBoxContainer/Team2Input
@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton


func _ready() -> void:
	team1_input.text = GameState.team_left
	team2_input.text = GameState.team_right
	play_button.grab_focus()


func _on_play_button_pressed() -> void:
	var t1 = team1_input.text.strip_edges()
	var t2 = team2_input.text.strip_edges()
	GameState.team_left = t1 if t1 != "" else "Player 1"
	GameState.team_right = t2 if t2 != "" else "Player 2"
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
