extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Camera").get_node("VisionBody").connect("player_spoted", self, "_player_spoted")

func _player_spoted():
	get_tree().reload_current_scene()
