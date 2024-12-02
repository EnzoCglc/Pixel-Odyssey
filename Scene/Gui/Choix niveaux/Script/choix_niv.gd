extends Control

func _on_niv_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 1/map_lvl_1.tscn")
	GameManager.gems_collected = 0

func _on_niv_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 2/map_lvl_2.tscn")
	GameManager.gems_collected = 0

func _on_niv_3_pressed() -> void:
	pass # Replace with function body.


func _on_niv_4_pressed() -> void:
	pass # Replace with function body.
