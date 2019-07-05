extends Area2D

# Declare member variables here. Examples:
var direction = 1
var speed = 2.2
const MAX_ANGLE = PI/2
const MIN_ANGLE = -MAX_ANGLE

signal player_spoted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += direction * delta * speed
	rotation = clamp(rotation, MIN_ANGLE, MAX_ANGLE)
	
	if rotation >= MAX_ANGLE:
		direction = -1
	elif rotation <= MIN_ANGLE:
		direction = 1

func _on_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("player_spoted")
	if body.get_name() == "TileMap":
		pass
