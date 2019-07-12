extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var beta
var c
var laser_color = Color(1.0, 0.5, 0.6)
var hit_pos = []
const r = 200

# This is half of vision angle
const HALF_OF_VISION_ANGLE = TAU / 9

# How many rays should be casted inside vision angle
const RAYS_IN_VISION_ANGLE = 60
const RAYS_ANGLE_INTERVAL = HALF_OF_VISION_ANGLE * 2 / RAYS_IN_VISION_ANGLE

var rot = 0.0
var direction = 1
var speed = 2.2
var vision_polygon
var poolVector2Array
var current_hit_pos
const MAX_ANGLE = PI/4
const MIN_ANGLE = -MAX_ANGLE

signal player_spoted

# Called when the node enters the scene tree for the first time.
func _ready():
	hit_pos.resize(RAYS_IN_VISION_ANGLE+1)
	vision_polygon = get_node("VisionBody/VisionPolygon")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	rot += direction * delta * speed
	var global_rot = rot - global_rotation
	
	if global_rot >= MAX_ANGLE:
		direction = -1
	elif global_rot <= MIN_ANGLE:
		direction = 1
	
	hit_pos[0] = Vector2(0.0, 0.0)
	
	for i in range(RAYS_IN_VISION_ANGLE):
		var current_angle = rot - HALF_OF_VISION_ANGLE + i * RAYS_ANGLE_INTERVAL
		var ray_destination = Vector2(cos(current_angle) * r + global_position.x, sin(current_angle) * r + global_position.y)
		var final_ray_destination = space_state.intersect_ray(global_position, ray_destination, [self], collision_mask)
		
		if final_ray_destination:
			print(final_ray_destination.collider.name)
			if final_ray_destination.collider.name == "Player":
				emit_signal("player_spoted")
			
			current_hit_pos = final_ray_destination.position
		else:
			current_hit_pos = ray_destination
			
		print("Guard rotation: " + str(global_rotation))
		
		hit_pos[i+1] = (current_hit_pos - global_position).rotated(-global_rotation)
		vision_polygon.polygon = PoolVector2Array(hit_pos)
		
	update()
		
func _draw():
	for h in hit_pos:
		if h:
			draw_line(Vector2(0.0, 0.0), h, laser_color)
