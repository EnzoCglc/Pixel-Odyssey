extends Node

# Signaux
signal gems_updated(gems_collected: int)
signal dash_cooldown_started(cooldown_time: float)
signal dash_cooldown_updated(time_left: float)
signal dash_cooldown_finished()

# Variables @export
@export var pos_checkpoint_x: int = 0
@export var pos_checkpoint_y: int = 0
@export var spawn_du_monde_x: int = 0
@export var spawn_du_monde_y: int = 0
@export var gems_requis: int = 4  # Seuil pour activer le portail

# Références aux nœuds exportées pour pouvoir les assigner dans l'inspecteur
@export var player_node_path: NodePath
@export var alert_label_path: NodePath  # Chemin vers le Label

# Variables normales
var checkpoint = 0
var speed: float = 200
var jump_velocity = -450
var jumps_count = 0
var max_jump = 2
var gems_collected: int = 0
var portal_open: bool = false

# Variables @onready
var p_layer: CharacterBody2D
var alert_label: Label  # Variable pour stocker le Label

func _ready():
	# Récupérer le Label à partir du chemin
	if not alert_label_path.is_empty():
		alert_label = get_node_or_null(alert_label_path)
	await get_tree().create_timer(0.5).timeout
	find_player()

func find_player():
	# Tenter d'obtenir les références aux nœuds
	if not player_node_path.is_empty():
		p_layer = get_node_or_null(player_node_path)

	# Si joueur non trouvé via le chemin, chercher par groupe
	if p_layer == null:
		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			p_layer = players[0]

# Méthode pour ajouter des gems
func collect_gem():
	gems_collected += 1
	gems_updated.emit(gems_collected)
	check_threshold()

# Vérifie si le seuil est atteint
func check_threshold():
	if gems_collected >= gems_requis:
		portal_open = true

# Méthode pour afficher une alerte à l'écran
func afficher_alerte(message: String):
	if alert_label != null:
		alert_label.text = message
		alert_label.visible = true
		# Masquer le message après 2 secondes
		await get_tree().create_timer(2.0).timeout
		alert_label.visible = false
	else:
		print("Alerte: " + message)  # Fallback si le label n'existe pas

# Méthode pour respawn le joueur
func respawn():
	# Re-vérifier le joueur s'il n'est pas déjà trouvé
	if p_layer == null:
		find_player()

	if p_layer == null:
		print("Erreur: Impossible de respawn le joueur - référence manquante")
		return

	if checkpoint >= 1:
		p_layer.position = Vector2(pos_checkpoint_x, pos_checkpoint_y)
	else:
		p_layer.position = Vector2(spawn_du_monde_x, spawn_du_monde_y)

func _on_checkpoint_checkpoint_actif() -> void:
	checkpoint += 1

func _on_deathzone_death() -> void:
	respawn()

func _on_spike_death() -> void:
	respawn()

func _on_slime_death() -> void:
	respawn()

func _on_slime_2_death() -> void:
	respawn()
