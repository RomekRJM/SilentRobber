extends Node2D

var timer
var exit
var total_diamonds = 0

func _ready():
	_init_enemies()
	_init_diamonds()
	_init_exit()
	timer = find_node("TimerLabel")

func _player_spoted():
	get_tree().reload_current_scene()

func _stop_timer():
	timer.deactivate_timer()
	
func _remove_diamond():
	total_diamonds -= 1
	
	if total_diamonds <= 0:
		exit.set_visible(true)

func _player_reached_exit():
	_stop_timer()
	
func _init_exit():
	exit = find_node("Exit")
	exit.set_visible(false)
	exit.connect("player_entered", self, "_player_reached_exit")
	
func _init_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.connect("player_spoted", self, "_player_spoted")
		
func _init_diamonds():
	for diamond in get_tree().get_nodes_in_group("Diamonds"):
		diamond.connect("diamond_picked", self, "_remove_diamond")
		total_diamonds += 1