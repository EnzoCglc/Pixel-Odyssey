extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Gui/Choix niveaux/Choix niv.tscn")

func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Gui/Menu Option/Options_menu.tscn")


func _on_exit_pressed() -> void:
		get_tree().quit()
