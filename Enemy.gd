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
var vision_polygon
var poolVector2Array
var current_hit_pos
const MAX_ANGLE = PI/2
const MIN_ANGLE = -MAX_ANGLE

signal player_spoted

# Called when the node enters the scene tree for the first time.
func _ready():
	hit_pos.resize(rays+1)
	vision_polygon = get_node("VisionBody/VisionPolygon")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	rot += direction * delta * speed
	
	if rot >= MAX_ANGLE:
		direction = -1
	elif rot <= MIN_ANGLE:
		direction = 1
	
	hit_pos[0] = Vector2(0.0, 0.0)
	
	for i in range(rays):
		var current_angle = rot - alpha + i * sight_step
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
