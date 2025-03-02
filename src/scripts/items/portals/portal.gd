extends Area2D

# Signal pour indiquer que le joueur n'a pas assez de gems
signal not_enough_gems(message: String)

@onready var game_manager: Node = $"/root/GameManager"

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		# Vérifier si le joueur a assez de gems pour activer le portail
		if game_manager.gems_collected >= game_manager.gems_requis:
			get_tree().change_scene_to_file("res://src/scenes/ui/level_select/Choix niv.tscn")
		else:
			# Émettre un signal si le joueur n'a pas assez de gems
			not_enough_gems.emit("Vous n'avez pas assez de gems pour activer le portail!")
