extends CanvasLayer

@onready var label_coins: Label = $Label_coins
@onready var alert_label: Label = $AlertLabel
@onready var dash_cooldown_label: Label = $Dash_Alerte
@onready var dash_cooldown_progress: ProgressBar = $DashCooldownProgress

func _ready():
	# Initialisation de la barre de progression
	dash_cooldown_progress.visible = false
	dash_cooldown_progress.max_value = 1.0
	dash_cooldown_progress.value = 1.0

	# Connexion des signaux via GameManager
	GameManager.connect("gems_updated", self._on_gems_updated)
	GameManager.connect("dash_cooldown_started", self._on_dash_cooldown_started)
	GameManager.connect("dash_cooldown_updated", self._on_dash_cooldown_updated)
	GameManager.connect("dash_cooldown_finished", self._on_dash_cooldown_finished)

	# Connexion du portail
	var portal = get_tree().get_nodes_in_group("Portal")
	if portal.size() > 0:
		portal[0].connect("not_enough_gems", self._on_not_enough_gems)

func _on_gems_updated(gems_collected: int):
	label_coins.text = "X" + str(gems_collected)

func _on_not_enough_gems(message: String):
	alert_label.text = message
	alert_label.visible = true
	await get_tree().create_timer(2.0).timeout
	alert_label.visible = false

func _on_dash_cooldown_started(cooldown_time: float):
	dash_cooldown_label.visible = true
	dash_cooldown_progress.visible = true
	dash_cooldown_progress.max_value = cooldown_time
	dash_cooldown_progress.value = cooldown_time

func _on_dash_cooldown_updated(time_left: float):
	dash_cooldown_progress.value = time_left
	dash_cooldown_label.text = "Dash cooldown:"

func _on_dash_cooldown_finished():
	dash_cooldown_label.visible = false
	dash_cooldown_progress.visible = false
