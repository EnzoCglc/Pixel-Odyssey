extends Node2D


@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var despawn: AnimatedSprite2D = $Area2D/Despawn
@onready var animated_sprite_2d: AnimatedSprite2D = $Area2D/AnimatedSprite2D

@export var Speed = 400 #Valeur de base
@export var timer = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	anim_player.play("Collect")
	despawn.play("default")
	GameManager.speed = Speed
	await get_tree().create_timer(timer).timeout
	GameManager.speed = 200
