extends Label

var update_timer = true
var total_time = 0.0

func _ready():
	activate_timer()

func _process(delta):
	if update_timer:
		total_time += delta
		
	set_text(time_in_mm_ss_ms(total_time))


func time_in_mm_ss_ms(total_time):
	var mm = int(floor(total_time)) / 60
	var seconds = total_time - (mm * 60)
	var ss = int(floor(seconds))
	var ms = (seconds - ss) * 10
	
	return "%02d:%02d.%01d" % [mm, ss, ms]
	
func activate_timer():
	update_timer = true

func deactivate_timer():
	update_timer = false