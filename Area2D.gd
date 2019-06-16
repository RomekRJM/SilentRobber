extends KinematicBody2D

# Declare member variables here. Examples:
export var speed = 400
var screen_size
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.screen_size = get_viewport_rect().size

func _physics_process(delta):
	var velocity = Vector2()
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		velocity.x = -1
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		velocity.x = 1
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		velocity.y = -1
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		velocity.y = 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	
	move_and_collide(velocity)
	

