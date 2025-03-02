extends CharacterBody2D

# Constantes
const DEFAULT_SPEED = 200
const DEFAULT_JUMP_VELOCITY = -450
const DEFAULT_MAX_JUMP = 2

# Variables normales
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_direction = 1  # 1 pour droite, -1 pour gauche
var can_jump = true
var can_dash = true
var is_dashing = false
var jumps_count = 0  # Compteur local de sauts
var dash_speed = 1200
var dash_duration = 0.2
var dash_cooldown = 1

# Variables @onready
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_song: AudioStreamPlayer = $Jump_song
@onready var particule: AnimatedSprite2D = $particule
@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer
@onready var dash_particles: GPUParticles2D = $DashParticles

# Signals
signal dash_cooldown_started(cooldown_time: float)
signal dash_cooldown_updated(time_left: float)
signal dash_cooldown_finished()

func _ready():
	add_to_group("Player")

	# Initialisation de l'état de dash
	is_dashing = false
	can_dash = true

	# Initialiser les particules
	if dash_particles:
		dash_particles.amount_ratio = 0.0
		dash_particles.emitting = false

	# Connecter les timers
	dash_duration_timer.timeout.connect(_on_dash_duration_timeout)
	dash_cooldown_timer.timeout.connect(_on_dash_cooldown_timeout)

func _physics_process(delta):
	process_input()
	update_physics(delta)
	update_animation()

func process_input():
	# Gestion du mouvement
	if Input.is_action_pressed("move_left"):
		velocity.x = -DEFAULT_SPEED
		current_direction = -1
	elif Input.is_action_pressed("move_right"):
		velocity.x = DEFAULT_SPEED
		current_direction = 1
	else:
		velocity.x = move_toward(velocity.x, 0, DEFAULT_SPEED)

	# Gestion du dash
	if Input.is_action_just_pressed("dash") and can_dash and not is_dashing:
		start_dash()

	# Gestion du saut
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and not is_dashing:
		if is_on_floor():
			jumps_count = 0

		if jumps_count < DEFAULT_MAX_JUMP:
			velocity.y = DEFAULT_JUMP_VELOCITY
			jumps_count += 1
			if jump_song:
				jump_song.play()
			
			# Jouer les particules de saut pour le double saut
			if jumps_count == 2 and particule:
				particule.play("Jump_particules")

func update_physics(delta):
	# Applique la gravité seulement si on ne dash pas
	if not is_on_floor() and not is_dashing:
		velocity.y += gravity * delta

	# Forcer une petite gravité même en dash
	if not is_on_floor() and is_dashing and velocity.y > 0:
		velocity.y += gravity * delta * 0.1

	# Vérifier si le joueur vient de toucher le sol
	var was_in_air = not is_on_floor()
	move_and_slide()
	var just_landed = was_in_air and is_on_floor()

	# Jouer les particules de saut si le joueur vient de toucher le sol
	if just_landed and particule:
		particule.play("Jump_particules")

func update_animation():
	if animated_sprite_2d == null:
		return

	animated_sprite_2d.flip_h = current_direction < 0

	if is_dashing:
		animated_sprite_2d.play("Run")
	elif not is_on_floor():
		play_air_animations()
	else:
		play_ground_animations()

func start_dash():
	can_dash = false
	is_dashing = true
	velocity = Vector2(current_direction * dash_speed, 0)

	# Activer les particules
	if dash_particles:
		dash_particles.amount_ratio = 1.0
		dash_particles.emitting = true

	dash_duration_timer.start(dash_duration)

func _on_dash_duration_timeout():
	is_dashing = false
	velocity.x = move_toward(velocity.x, 0, dash_speed)

	# Désactiver les particules
	if dash_particles:
		dash_particles.amount_ratio = 0.0
		dash_particles.emitting = false

	# Émettre le signal de début de cooldown via GameManager
	GameManager.emit_signal("dash_cooldown_started", dash_cooldown)
	dash_cooldown_timer.start(dash_cooldown)

func _on_dash_cooldown_timeout():
	can_dash = true
	GameManager.emit_signal("dash_cooldown_finished")

func play_air_animations():
	if velocity.y < 0:
		if jumps_count == 2:
			animated_sprite_2d.play("Double_Jump")
		else:
			animated_sprite_2d.play("Jump")
	else:
		animated_sprite_2d.play("Fall")

func play_ground_animations():
	if velocity.x != 0:
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Stand")

func _process(delta):
	# Mettre à jour le temps restant du cooldown via GameManager
	if dash_cooldown_timer.time_left > 0:
		GameManager.emit_signal("dash_cooldown_updated", dash_cooldown_timer.time_left)
