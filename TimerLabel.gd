extends Label

var total_time = 0.0

func _ready():
	pass


func _process(delta):
	total_time += delta
	set_text(time_in_mm_ss_ms(total_time))


func time_in_mm_ss_ms(total_time):
	var mm = int(floor(total_time)) / 60
	var seconds = total_time - (mm * 60)
	var ss = int(floor(seconds))
	var ms = (seconds - ss) * 10
	
	return "%02d:%02d.%01d" % [mm, ss, ms]