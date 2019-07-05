extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var hit_pos
var laser_color = Color(1.0, 0.5, 0.6)

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
		update()
		
		if result.collider.name == "Player":
			pass
		
func _draw():
	if hit_pos:
		draw_circle((hit_pos - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(0.0, 0.0), (hit_pos - position).rotated(-rotation), laser_color)
