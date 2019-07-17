extends Node2D

func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.connect("player_spoted", self, "_player_spoted")

func _player_spoted():
	get_tree().reload_current_scene()
