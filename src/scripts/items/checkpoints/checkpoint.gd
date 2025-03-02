extends Area2D

# Signal en snake_case pour suivre les conventions
signal checkpoint_actif

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = $"/root/GameManager"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Activer le checkpoint sans vérifier les gems
		animated_sprite_2d.play("on")
		checkpoint_actif.emit()
		# Enregistrer la position du checkpoint dans le GameManager
		game_manager.pos_checkpoint_x = global_position.x
		game_manager.pos_checkpoint_y = global_position.y
