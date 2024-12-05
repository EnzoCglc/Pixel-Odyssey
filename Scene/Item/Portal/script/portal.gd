extends Area2D

# État du portail
var niv: int = 0 

func _on_body_entered(_body: Node) -> void:
	if GameManager.portal_open == true:
		get_tree().change_scene_to_file("res://Scene/Gui/Choix niveaux/Choix niv.tscn")
