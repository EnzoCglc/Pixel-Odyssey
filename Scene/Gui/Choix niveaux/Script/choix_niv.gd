extends Control

func _ready():
	print("Niveau actuel :", portal.niv)  # Lire la valeur de la variable globale
	print("Niveau après modification :", portal.niv)


func _on_niv_1_pressed() -> void:
	print(portal.niv)


func _on_niv_2_pressed() -> void:
	pass # Replace with function body.


func _on_niv_3_pressed() -> void:
	pass # Replace with function body.


func _on_niv_4_pressed() -> void:
	pass # Replace with function body.
