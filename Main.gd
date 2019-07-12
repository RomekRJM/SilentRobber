extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		# enemy.find_node("Enemy").connect("player_spoted", self, "_player_spoted")
		enemy.find_node("Enemy")

func _player_spoted():
	get_tree().reload_current_scene()
