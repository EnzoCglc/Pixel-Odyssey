extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Gui/Choix niveaux/Choix niv.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Gui/Menu Option/Options_menu.tscn")


func _on_button_3_pressed() -> void:
	get_tree().quit()
