extends Area2D

signal Death

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Death.emit()
