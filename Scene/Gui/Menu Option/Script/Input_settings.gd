extends Control

@onready var input_button_scene = preload("res://Scene/Gui/Menu Option/input_button.tscn")
@onready var action_list = $"PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/Action list"

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"move_left": "Allez à gauche",
	"move_right": "Allez à droite",
	"jump": "Sauter",
	
}

func _ready():
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions: 
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Appuyer pour configurer ..."

func _input(event):
	if is_remapping:
		if event is InputEventKey or (event is InputEventMouseButton and event.pressed):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			# Sauvegarde la nouvelle configuration dans les paramètres du projet
			_save_action_to_project_settings(action_to_remap)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null

func _update_action_list(button, event):
	if event is InputEventKey:
		button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

func _save_action_to_project_settings(action):
	# Récupère tous les événements pour l'action spécifiée
	var events = InputMap.action_get_events(action)
	var event_list = []
	
	for event in events:
		event_list.append(event)
	
	# Sauvegarde dans les paramètres du projet sous `input/`
	ProjectSettings.set_setting("input/" + action, event_list)
	# Enregistre les modifications dans `project.godot`
	ProjectSettings.save()

func _on_button_pressed() -> void:
	_create_action_list()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scene/Gui/Menu start/start.tscn")
	else:
		return
