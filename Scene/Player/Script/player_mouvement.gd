extends CharacterBody2D

# Utilise la gravité par défaut du projet
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Références aux nœuds
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var jump_song: AudioStreamPlayer = $Jump_song
@onready var particule: AnimatedSprite2D = $Particule



# Variables de contrôle
var current_direction = 1  # 1 pour droite, -1 pour gauche
var current_animation = ""  # Animation actuellement jouée

func _ready():
	add_to_group("Player")  # Ajout à un groupe pour une gestion globale

func _physics_process(delta):
	# Appels principaux
	process_input()  # Gère les entrées utilisateur et les actions (saut, déplacements)
	update_physics(delta)  # Mise à jour de la physique du personnage
	update_animation()  # Mise à jour des animations en fonction de l'état

# Variable pour suivre l'état du saut et particule
var can_jump = true


func process_input():
	var direction = Input.get_axis("move_left", "move_right")  # Récupère l'axe de déplacement
	if direction != 0:
		velocity.x = direction * GameManager.speed
		current_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, GameManager.speed)

	# Gestion du saut
	if Input.is_action_just_pressed("ui_accept"):
		# Si le personnage touche le sol, réinitialise le compteur de sauts
		if is_on_floor():
			GameManager.jumps_count = 0
			can_jump = true  # Autorise le saut à nouveau

		# Si le joueur est autorisé à sauter et n'a pas atteint la limite
		if GameManager.jumps_count < GameManager.max_jump:
			velocity.y = GameManager.jump_velocity
			GameManager.jumps_count += 1
			jump_song.play()
			
# Mise à jour de la physique
func update_physics(delta):
	# Applique la gravité si le personnage n'est pas au sol
	if not is_on_floor():
		velocity.y += gravity * delta

	# Déplace le personnage avec détection de collisions
	move_and_slide()

# Mise à jour des animations
func update_animation():
	animated_sprite_2d.flip_h = current_direction < 0
	
	# Si le personnage n'est pas au sol (en l'air)
	if not is_on_floor():
		if velocity.y < 0:
			# En train de sauter
			if GameManager.jumps_count == 2:
				# Animation de double saut
				animated_sprite_2d.play("DoubleJump")
				particule.play("Jump_particules")
				current_animation = "DoubleJump"
			elif current_animation != "Jump":
				# Animation de premier saut (simple)
				animated_sprite_2d.play("Jump")
				current_animation = "Jump"
		else:
			# En train de tomber
			if current_animation != "Fall":
				animated_sprite_2d.play("Fall")
				current_animation = "Fall"
	
	# Si le personnage est au sol
	elif velocity.x != 0:
		# Animation de course    
		if current_animation != "Run":
			animated_sprite_2d.play("Run")
			current_animation = "Run"
	
	# Si le personnage est immobile (arrêt)
	else:
		if current_animation != "Stand":
			animated_sprite_2d.play("Stand")
			current_animation = "Stand"
