extends Control

func _on_niv_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 1/map_lvl_1.tscn")
	GameManager.gems_collected = 0

func _on_niv_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 2/map_lvl_2.tscn")
	GameManager.gems_collected = 0

func _on_niv_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 3/map_lvl_3.tscn")
	GameManager.gems_collected = 0

func _on_niv_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Niveaux/LVL 4/map_lvl_4.tscn")
	GameManager.gems_collected = 0
