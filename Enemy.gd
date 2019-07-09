extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var beta
var p
var c
var laser_color = Color(1.0, 0.5, 0.6)
var hit_pos = []
const r = 50
const tau = 2 * PI 
const alpha = tau / 6
const rays = 60
const sight_step = alpha * 2 / rays

# Called when the node enters the scene tree for the first time.
func _ready():
	hit_pos.resize(rays)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, get_tree().get_current_scene().get_node("Player").position, 
		[self], collision_mask)

	if result:
		p = result.position
		c = position
		beta = (c-p).angle()
		
		for i in range(rays):
			var current_angle = beta - alpha + i * sight_step
			var ray_destination = Vector2(cos(current_angle) * r + c.x, sin(current_angle) * r + c.y)
			var final_ray_destination = space_state.intersect_ray(position, ray_destination, [self], collision_mask)
			
			if final_ray_destination:
				hit_pos[i] = final_ray_destination.position
			else:
				hit_pos[i] = ray_destination
			
		update()
		
		if result.collider.name == "Player":
			pass
		
func _draw():
	if p:
		var pos = (p - position).rotated(-rotation)
		draw_line(Vector2(0.0, 0.0), pos, laser_color)
		draw_circle(pos, 5, laser_color)

		for h in hit_pos:
			draw_line(Vector2(0.0, 0.0), (p-h).rotated(-rotation), laser_color)
