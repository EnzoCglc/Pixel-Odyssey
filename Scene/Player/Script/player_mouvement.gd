extends CharacterBody2D

# Constantes pour la vitesse et le saut
#const SPEED = 200.0
#const JUMP_VELOCITY = -550.0

# Variables pour la gestion de la gravité et du saut
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_jump_duration = 0.2  # Durée pendant laquelle le personnage peut sauter
var can_jump_timer = 0.0  # Timer pour le saut

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D  # gerer la boite de collision 

var current_direction = 1  # 1 pour droite, -1 pour gauche

func _ready():
	# Initialisation du timer de saut
	can_jump_timer = 0.0
	add_to_group("Player")
	

func _physics_process(delta):
	# Mise à jour de la vélocité en Y
	if not is_on_floor():
		velocity.y += gravity * delta
		can_jump_timer -= delta  # Décrémente le délai de saut
	else:
		velocity.y = 0
		can_jump_timer = can_jump_duration  # Réinitialise le délai de saut

	# Gère le saut
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or can_jump_timer > 0):
		velocity.y = GameManager.jump_velocity

	# Mise à jour de la vélocité en X
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * GameManager.speed
		current_direction = direction  # Met à jour la direction actuelle
	else:
		velocity.x = move_toward(velocity.x, 0, GameManager.speed)
	
	if current_direction != -1:
		collision_shape_2d.position = Vector2(0, 0)
	elif current_direction != 1:
		collision_shape_2d.position = Vector2(22, 0)

	# Déplacement du personnage
	move_and_slide()

	# Mise à jour de l'animation en fonction de la vélocité
	var is_moving = velocity.length() > 0
	if is_moving:
		animated_sprite_2d.play("Run")  # Joue l'animation de course
		animated_sprite_2d.flip_h = current_direction < 0  # Retourne le sprite selon la direction actuelle
	else:
		if is_on_floor():
			animated_sprite_2d.play("Stand")  # Joue l'animation d'arrêt
		else:
			animated_sprite_2d.play("Jump")  # Joue l'animation de saut
			animated_sprite_2d.flip_h = current_direction < 0  # Garder la direction en l'air
