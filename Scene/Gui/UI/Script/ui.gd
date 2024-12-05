#extends CanvasLayer
#
## Référence au Label pour afficher le nombre de gemmes
#@onready var label_coins: Label = $Label_coins
#
## Signal pour notifier le GameManager quand l'UI doit être mise à jour
#signal gems_updated(gems_collected: int)
#
## Met à jour l'affichage des gemmes dans l'UI
#func update_ui(gems_collected: int):
	#label_coins.text = "X" + str(gems_collected)
	#gems_updated.emit(gems_collected)  # Émet le signal avec le nombre de gemmes
#
## Méthode pour désactiver l'UI (par exemple quand le portail est ouvert)
#func disable_ui():
	#visible = false
#extends CanvasLayer
#
#@onready var label_coins: Label = $Label_coins
#
#func _ready():
	#var game_manager = get_node("/root/GameManager")  # Assurez-vous que GameManager est bien dans /root
	#game_manager.connect("gems_updated", Callable(self, "_on_gems_updated"))  # Nom du signal corrigé
#
#func _on_gems_updated(gems_collected: int):
	#label_coins.text = "X" + str(gems_collected)  # Met à jour l'affichage des gemmes
	#print("test2")


extends CanvasLayer

@onready var label_coins: Label = $Label_coins

func _ready():
	GameManager.connect("gems_updated", self._on_gems_updated)

func _on_gems_updated(gems_collected: int):
	label_coins.text = "X" + str(gems_collected)
