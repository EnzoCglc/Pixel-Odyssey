extends Area2D

signal Checkpoint_actif

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var p_layer: CharacterBody2D = $"../PLayer"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimatedSprite2D.play("on")
		Checkpoint_actif.emit()
