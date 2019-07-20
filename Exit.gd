extends Area2D

signal player_entered

func _ready():
	pass 

func _on_Exit_body_entered(body):
	if visible and body.name == 'Player':
		emit_signal("player_entered")
