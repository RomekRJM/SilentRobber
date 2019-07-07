extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var hit_pos
var laser_color = Color(1.0, 0.5, 0.6)
const r = 150
const deg1 = PI / 180.0
const step = deg1
const rays = 90
const mid_ray = rays / 2
var perpendicular

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, get_tree().get_current_scene().get_node("Player").position, 
		[self], collision_mask)

	if result:
		hit_pos = result.position
		var normalized = hit_pos.normalized()
		perpendicular = Vector2(-normalized.y*200, normalized.x*200)
		print(hit_pos.length())
		update()
		
		if result.collider.name == "Player":
			pass
		
func _draw():
	if hit_pos:
		var pos = (hit_pos - position).rotated(-rotation)
		draw_line(Vector2(0.0, 0.0), pos, laser_color)
		draw_line(pos, perpendicular, laser_color)
		draw_circle(pos, 5, laser_color)

		for i in range(rays):
			draw_line(Vector2(0.0, 0.0), pos.rotated((mid_ray-i)*step), laser_color)
