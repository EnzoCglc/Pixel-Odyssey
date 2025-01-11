extends Node

# Gestion du personnage
@onready var p_layer: CharacterBody2D = $"../PLayer"

# Gestion globale Checkpoint
@export var Pos_Checkpoint_x = 0
@export var Pos_Checkpoint_y = 0

@export var Spawn_du_monde_x = 0
@export var Spawn_du_monde_y = 0
var checkpoint = 0

# Gestion stats player
var speed: float = 200
var jump_velocity = -450
var jumps_count = 0
var max_jump = 2

# Gestion globale des gems
var gems_collected: int = 0
@export var gems_requis: int = 4  # Seuil pour activer le portail
var portal_open: bool = false

# Signal pour notifier l'UI
signal gems_updated(gems_collected: int)

# Méthode pour ajouter des gems
func collect_gem():
	gems_collected += 1
	gems_updated.emit(gems_collected)
	#print(gems_collected) # Émet le signal avec le nombre de gemmes
	check_threshold()

# Vérifie si le seuil est atteint
func check_threshold():
	if gems_collected >= gems_requis:
		portal_open = true
		# Éventuellement émettre un autre signal pour indiquer que le portail est ouvert

# Méthode pour gérer la mort

func _on_checkpoint_checkpoint_actif() -> void:
	checkpoint += 1
	
func _on_deathzone_death() -> void:
	respawn()
func _on_spike_death() -> void:
	respawn()
		
func respawn():
	if checkpoint >= 1:
		p_layer.position = Vector2(Pos_Checkpoint_x, Pos_Checkpoint_y)
	else:
		p_layer.position = Vector2(Spawn_du_monde_x, Spawn_du_monde_y)
