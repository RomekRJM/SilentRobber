extends PathFollow2D

# Declare member variables here. Examples:
export var speed = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	self.set_offset(self.get_offset() + speed * delta)
