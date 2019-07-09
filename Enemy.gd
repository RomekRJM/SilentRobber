extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var beta
var c
var laser_color = Color(1.0, 0.5, 0.6)
var hit_pos = []
const r = 200
const alpha = TAU / 6
const rays = 60
const sight_step = alpha * 2 / rays

var rot = 0.0
var direction = 1
var speed = 2.2
const MAX_ANGLE = PI
const MIN_ANGLE = -MAX_ANGLE

# Called when the node enters the scene tree for the first time.
func _ready():
	hit_pos.resize(rays)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	rot += direction * delta * speed
	rot = clamp(rot, MIN_ANGLE, MAX_ANGLE)
	
	if rot >= MAX_ANGLE:
		direction = -1
	elif rot <= MIN_ANGLE:
		direction = 1
		
	for i in range(rays):
		var current_angle = rot - alpha + i * sight_step
		var ray_destination = Vector2(cos(current_angle) * r + position.x, sin(current_angle) * r + position.y)
		var final_ray_destination = space_state.intersect_ray(position, ray_destination, [self], collision_mask)
		
		if final_ray_destination:
			hit_pos[i] = final_ray_destination.position
		else:
			hit_pos[i] = ray_destination
		
	update()
		
func _draw():
	for h in hit_pos:
		if h:
			draw_line(Vector2(0.0, 0.0), (h-position).rotated(-rotation), laser_color)
