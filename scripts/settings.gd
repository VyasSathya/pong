extends Control

## Keybind settings screen

@onready var p1_up_btn: Button = $VBoxContainer/P1Up/Button
@onready var p1_down_btn: Button = $VBoxContainer/P1Down/Button
@onready var p2_up_btn: Button = $VBoxContainer/P2Up/Button
@onready var p2_down_btn: Button = $VBoxContainer/P2Down/Button
@onready var back_button: Button = $VBoxContainer/BackButton

var waiting_for_key: String = ""
var active_button: Button = null

const ACTION_MAP = {
	"p1_up": "P1 Up",
	"p1_down": "P1 Down",
	"p2_up": "P2 Up",
	"p2_down": "P2 Down",
}


func _ready() -> void:
	_update_labels()
	back_button.grab_focus()

	p1_up_btn.pressed.connect(_start_rebind.bind("p1_up", p1_up_btn))
	p1_down_btn.pressed.connect(_start_rebind.bind("p1_down", p1_down_btn))
	p2_up_btn.pressed.connect(_start_rebind.bind("p2_up", p2_up_btn))
	p2_down_btn.pressed.connect(_start_rebind.bind("p2_down", p2_down_btn))


func _start_rebind(action: String, btn: Button) -> void:
	waiting_for_key = action
	active_button = btn
	btn.text = "Press a key..."


func _input(event: InputEvent) -> void:
	if waiting_for_key == "":
		return

	if event is InputEventKey and event.pressed:
		# Replace the action's input event
		InputMap.action_erase_events(waiting_for_key)
		var new_event = InputEventKey.new()
		new_event.physical_keycode = event.physical_keycode
		InputMap.action_add_event(waiting_for_key, new_event)

		waiting_for_key = ""
		active_button = null
		_update_labels()
		get_viewport().set_input_as_handled()


func _update_labels() -> void:
	p1_up_btn.text = _get_key_name("p1_up")
	p1_down_btn.text = _get_key_name("p1_down")
	p2_up_btn.text = _get_key_name("p2_up")
	p2_down_btn.text = _get_key_name("p2_down")


func _get_key_name(action: String) -> String:
	var events = InputMap.action_get_events(action)
	if events.size() > 0 and events[0] is InputEventKey:
		return events[0].as_text()
	return "Unset"


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
