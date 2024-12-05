extends CharacterBody2D

var speed = 2000
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * speed * delta
	set_direction()	
	move_and_slide()


func set_direction():
	var collide = ray_cast_2d.get_collider()
	if is_instance_valid(ray_cast_2d.get_collider()):
		print("test2")
		if collide.is_in_group("tilemap"):
			print("test")
