extends CharacterBody2D

# Vitesse de déplacement du mob
var speed: float = 75
# Direction du mob (1 pour droite, -1 pour gauche)
var direction: int = 1

# Gravité
var gravity: float = 500.0
# Vitesse de saut
var jump_velocity: float = -300.0
# Vitesse verticale actuelle
var velocity_y: float = 0.0

# Limites de déplacement
@export var left_limit: float = 0
@export var right_limit: float = 0

# Signal de la mort 
signal Death

# Référence au sprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Applique la gravité
	velocity_y += gravity * delta
	
	# Déplace le mob horizontalement
	velocity.x = direction * speed
	velocity.y = velocity_y
	
	# Applique le mouvement et gère les collisions
	move_and_slide()
	
	# Vérifie les limites et inverse la direction + flip le sprite
	if global_position.x <= left_limit or global_position.x >= right_limit:
		direction *= -1
		animated_sprite_2d.flip_h = (direction == 1)  # Flip si direction = gauche
	
	# Inverse la direction + flip le sprite si le mob touche un mur
	if is_on_wall():
		direction *= -1
		animated_sprite_2d.flip_h = (direction == 1)  # Flip si direction = gauche
	
	# Si le mob est sur le sol, réinitialise la vitesse verticale
	if is_on_floor():
		velocity_y = 0.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Death.emit()
