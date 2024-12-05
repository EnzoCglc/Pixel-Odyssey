extends Area2D

func _on_Area2D_body_entered(body):
	print("COLLISION")
	if body.is_in_group("Player"):
		# Permettre au joueur de passer à travers
		body.set_collision_mask(0)  # Désactive les collisions

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		# Bloquer le joueur après le saut
		body.set_collision_mask(1)  # Réactive les collisions
