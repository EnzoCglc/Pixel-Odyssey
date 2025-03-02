extends CanvasLayer

# Déclare un signal
signal coin_threshold_reached

var current_coin = 0
@onready var label_coins: Label = $Label_coins

func add_coins(amount: int):
	current_coin += amount
	label_coins.text = "X" + str(current_coin)

func _process(_delta):
	if current_coin >= 4:
		coin_threshold_reached.emit()
	if current_coin >= 5:
		ui_coin_disable()

func ui_coin_disable():
	self.visible = false
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://src/scenes/ui/level_select/Niveaux 2.tscn")
	else:
		return
