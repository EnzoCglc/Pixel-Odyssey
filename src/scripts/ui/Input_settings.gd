extends Control

# Préchargement de la scène du bouton d'entrée
@onready var input_button_scene = preload("res://src/scenes/ui/options/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

# Chemins des fichiers de configuration
const KEYBINDINGS_FILE = "user://keybindings.json"
const DEFAULT_KEYBINDINGS_FILE = "res://Scene/Gui/Menu Option/keybindings.json"

# Variables pour le remappage
var is_remapping = false
var action_to_remap = null
var remapping_button = null

# Dictionnaire des actions avec leurs descriptions
var input_actions = {
    "move_left": "Allez à gauche",
    "move_right": "Allez à droite",
    "jump": "Sauter",
    "dash": "Dash"
}

func _ready():
    load_keybindings()
    _create_action_list()

# Crée la liste des actions
func _create_action_list():
    for child in action_list.get_children():
        child.queue_free()
    
    for action in input_actions:
        var button = input_button_scene.instantiate()
        var action_label = button.find_child("LabelAction")
        var input_label = button.find_child("LabelInput")
        
        action_label.text = input_actions[action]
        var events = InputMap.action_get_events(action)
        input_label.text = events[0].as_text().trim_suffix(" (Physical)") if !events.is_empty() else "Non configuré"
        
        button.pressed.connect(_on_input_button_pressed.bind(action, button))
        action_list.add_child(button)

# Gestion du clic sur un bouton d'action
func _on_input_button_pressed(action: String, button: Button):
    if !is_remapping:
        is_remapping = true
        action_to_remap = action
        remapping_button = button
        button.find_child("LabelInput").text = "Appuyez sur une touche..."

# Gestion des entrées pour le remappage
func _input(event):
    if is_remapping:
        if event.is_action_pressed("ui_cancel"):
            _cancel_remapping()
            return
        
        if event is InputEventKey and event.pressed:
            if event.keycode in [KEY_CTRL, KEY_ALT, KEY_SHIFT, KEY_META]:
                return
            _finalize_remapping(event)
        
        elif event is InputEventMouseButton and event.pressed:
            _finalize_remapping(event)

func _finalize_remapping(event: InputEvent):
    InputMap.action_erase_events(action_to_remap)
    InputMap.action_add_event(action_to_remap, event)
    save_keybindings()
    _update_action_list(remapping_button, event)
    is_remapping = false
    action_to_remap = null
    remapping_button = null
    get_viewport().set_input_as_handled()

# Met à jour l'affichage d'un bouton
func _update_action_list(button: Button, event: InputEvent):
    var input_label = button.find_child("LabelInput")
    input_label.text = event.as_text().trim_suffix(" (Physical)")

# Annule le remappage
func _cancel_remapping():
    if remapping_button:
        var events = InputMap.action_get_events(action_to_remap)
        var input_label = remapping_button.find_child("LabelInput")
        input_label.text = events[0].as_text().trim_suffix(" (Physical)") if !events.is_empty() else "Non configuré"
    is_remapping = false
    action_to_remap = null
    remapping_button = null

# Charge les configurations
func load_keybindings():
    if !FileAccess.file_exists(KEYBINDINGS_FILE):
        create_default_keybindings()

    var file = FileAccess.open(KEYBINDINGS_FILE, FileAccess.READ)
    if !file:
        push_error("Erreur de chargement du fichier de configuration")
        return

    var json = JSON.new()
    var error = json.parse(file.get_as_text())
    file.close()

    if error == OK:
        var data = json.data
        for action in data:
            if input_actions.has(action):
                InputMap.action_erase_events(action)
                var event = create_event_from_json(data[action])
                if event:
                    InputMap.action_add_event(action, event)
    else:
        push_error("Erreur JSON: %s (ligne %d)" % [json.get_error_message(), json.get_error_line()])

# Crée un événement depuis le JSON
func create_event_from_json(event_data: Dictionary) -> InputEvent:
    var event: InputEvent = null

    match event_data.get("type"):
        "InputEventKey":
            event = InputEventKey.new()
            event.keycode = OS.find_keycode_from_string(event_data.get("keycode", "KEY_UNKNOWN"))
        "InputEventMouseButton":
            event = InputEventMouseButton.new()
            event.button_index = event_data.get("button_index", MOUSE_BUTTON_NONE)

    return event

# Sauvegarde les configurations
func save_keybindings():
    var data = {}

    for action in input_actions:
        var events = InputMap.action_get_events(action)
        if !events.is_empty():
            var event = events[0]
            var event_data = {}

            if event is InputEventKey:
                event_data["type"] = "InputEventKey"
                event_data["keycode"] = OS.get_keycode_string(event.keycode)

            data[action] = event_data

    var file = FileAccess.open(KEYBINDINGS_FILE, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(data, "\t"))
        file.close()

# Réinitialisation des contrôles
func _on_button_pressed():
    if FileAccess.file_exists(KEYBINDINGS_FILE):
        DirAccess.remove_absolute(KEYBINDINGS_FILE)
    load_keybindings()
    _create_action_list()

# Retour au menu
func _process(_delta: float):
    if Input.is_action_just_pressed("ui_cancel") and !is_remapping:
        get_tree().change_scene_to_file("res://src/scenes/ui/main_menu/start.tscn")

# Crée les configurations par défaut
func create_default_keybindings():
    var default_file = FileAccess.open(DEFAULT_KEYBINDINGS_FILE, FileAccess.READ)
    if default_file:
        var content = default_file.get_as_text()
        default_file.close()

        var file = FileAccess.open(KEYBINDINGS_FILE, FileAccess.WRITE)
        if file:
            file.store_string(content)
            file.close()