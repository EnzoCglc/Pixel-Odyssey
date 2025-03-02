extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/ui/level_select/Choix niv.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/ui/options/Options_menu.tscn")


func _on_button_3_pressed() -> void:
	get_tree().quit()
