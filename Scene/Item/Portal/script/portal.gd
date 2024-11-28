extends Area2D

# État du portail
var open = false
var niv: int = 0 

func _ready():
	# Connecte le portail au signal du Game Manager
	GameManager.connect("gems_threshold_reached", Callable(self, "_on_gems_threshold_reached"))

func _on_body_entered(_body: Node) -> void:
	# Si le portail est ouvert, démarre l'interaction
	if open:
		portal.niv += 1  # Modifier la variable globale
		print(portal.niv)  # Affiche la valeur globale
		get_tree().change_scene_to_file("res://Scene/Gui/Choix niveaux/Choix niv.tscn")

func _on_game_manager_gems_threshold_reached() -> void:
	open = true
	print("actif")
