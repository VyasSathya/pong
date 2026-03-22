extends Control

@onready var winner_label: Label = $VBoxContainer/WinnerLabel
@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var rematch_button: Button = $VBoxContainer/RematchButton
@onready var menu_button: Button = $VBoxContainer/MenuButton


func _ready() -> void:
	winner_label.text = "%s Wins!" % GameState.winner
	score_label.text = "%s  %d  -  %d  %s" % [
		GameState.team_left,
		GameState.final_score_left,
		GameState.final_score_right,
		GameState.team_right,
	]
	rematch_button.grab_focus()


func _on_rematch_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
