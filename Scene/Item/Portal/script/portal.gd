extends Area2D

# État du portail
var open = false
var niv: int = 0

func _ready():
	# Récupère le GameManager
	var game_manager = get_node("/root/GameManager")  # Adaptez le chemin selon votre projet

func _process(_delta: float):
	# Vérifie si le portail doit être ouvert
	var game_manager = get_node("/root/GameManager")  # Vérifiez que ce chemin est correct
	if game_manager.portal_open and not open:
		open = true
		#print("Portail activé par _process !")

func _on_body_entered(_body: Node) -> void:
	if open == true:
		niv += 1  # Modifier la variable globale
		get_tree().change_scene_to_file("res://Scene/Gui/Choix niveaux/Choix niv.tscn")
