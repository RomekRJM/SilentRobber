extends Node2D

var timer

func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.connect("player_spoted", self, "_player_spoted")
	
	timer = find_node("TimerLabel")

func _player_spoted():
	get_tree().reload_current_scene()

func _stop_timer():
	timer.deactivate_timer()