extends KinematicBody2D

const CENTER = Vector2(0, 0)
const NB_POINTS = 32

export var speed = 400
export var sound_color = Color(0.4, 0.4, 0.6, 0.75)
export var sound_radius = 36
export var sound_speed = 10

var radius
var pressed_time = 0
var velocity

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		velocity.x = -1
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		velocity.x = 1
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		velocity.y = -1
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		velocity.y = 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		pressed_time += delta
	else:
		pressed_time = 0
	
	move_and_slide(velocity)
	update()
	
func _draw():
	if velocity:
		radius = sound_radius * sin(pressed_time * sound_speed)
		draw_circle_arc_poly(CENTER, radius, 0, 360, sound_color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(NB_POINTS + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / NB_POINTS - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	draw_polygon(points_arc, colors)