extends Area2D

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
# Référence au compteur de gems

func _on_body_entered(_body: Node) -> void:
	GameManager.collect_gem() # Informe le Game Manager
	anim_player.play("fade_out") # Joue l'animation de disparition
	queue_free() # Détruit l'objet après la collecte
