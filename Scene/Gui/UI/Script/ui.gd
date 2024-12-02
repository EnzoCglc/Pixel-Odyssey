extends CanvasLayer

@onready var label_coins: Label = $Label_coins

func _ready():
	var game_manager = get_node("/root/GameManager")  # Assurez-vous que GameManager est bien dans /root
	game_manager.connect("gems_updated", Callable(self, "_on_gems_updated"))  # Nom du signal corrigé

func _on_gems_updated(gems_collected: int):
	label_coins.text = "X" + str(gems_collected)  # Met à jour l'affichage des gemmes
