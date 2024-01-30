extends Node

const COMBO_MAX_TIME = 5
const COMBO_MIN = 1

var current_points = 0
var character_alive = false
var current_combo = COMBO_MIN

signal update_points(int)
signal update_combo(int)

@onready var globals = get_node("/root/MainScene")

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_points(0)
	_on_increase_combo(0)
	$ComboTimer.timeout.connect(_on_combo_over)
	
func _on_combo_over():
	current_combo = COMBO_MIN
	emit_signal("update_combo", current_combo)
	
	
func on_game_start():
	current_points = 0
	current_combo = COMBO_MIN
	_update_points(0)
	_on_increase_combo(0)

func on_monster_killed(points, combo_raise):
	_update_points(points)
	_on_increase_combo(combo_raise)
	pass

func _on_increase_combo(combo_raise : int):
	current_combo += combo_raise
	$ComboTimer.start(COMBO_MAX_TIME)
	emit_signal("update_combo", current_combo)

func _update_points(points : float):
	current_points += points
	emit_signal("update_points", current_points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character_alive:
		_update_points(current_combo * delta)
	pass

func _on_map_loaded():
	character_alive = true
	pass # Replace with function body.
