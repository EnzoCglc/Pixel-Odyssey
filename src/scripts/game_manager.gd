extends Node

# Signals
signal gems_updated(gems_collected: int)
signal dash_cooldown_started(cooldown_time: float)
signal dash_cooldown_updated(time_left: float)
signal dash_cooldown_finished()

# Variables
var gems_collected: int = 0

func add_gems(amount: int):
	gems_collected += amount
	emit_signal("gems_updated", gems_collected)