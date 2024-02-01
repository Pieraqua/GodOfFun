extends Node

class_name SistemaDeWave

@onready var globals = get_node("/root/MainScene")

var Waves : Array[Array] = [
	[295, "res://Scenes/Waves/Wave_2.tscn"],
	[290, "res://Scenes/Waves/Wave_1.tscn"],
	[285, "res://Scenes/Waves/Wave_2.tscn"],
	[280, "res://Scenes/Waves/Wave_1.tscn"],
	[275, "res://Scenes/Waves/Wave_2.tscn"],
	[270, "res://Scenes/Waves/Wave_3.tscn"],
	[265, "res://Scenes/Waves/Wave_4.tscn"],
	[260, "res://Scenes/Waves/Wave_5.tscn"],
	[255, "res://Scenes/Waves/Wave_6.tscn"],
	[250, "res://Scenes/Waves/Wave_7.tscn"],
	[245, "res://Scenes/Waves/Wave_8.tscn"],
	[240, "res://Scenes/Waves/Wave_9.tscn"],
	[235, "res://Scenes/Waves/Wave_10.tscn"],
	[230, "res://Scenes/Waves/Wave_10.tscn"]
]

signal spawn_wave(String)

@export var time_left = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerJogo.start(time_left)
	$TimerJogo.timeout.connect(_time_over)
	
	$Timer1Sec.start(1)
	$Timer1Sec.timeout.connect(_update_time)
	
	$TimerWaves.timeout.connect(_on_timer_end)
	$TimerWaves.start(clamp(time_left - Waves[0][0], 0, time_left))
	time_left = time_left - clamp(time_left - Waves[0][0], 0, time_left)
	
func _update_time():
	globals.get("ui").update_timer($TimerJogo.time_left)
	pass
	
func _time_over():
	pass

func _on_timer_end():
	emit_signal("spawn_wave", Waves[0][1])
	Waves.erase(Waves[0])
	
	if !Waves.is_empty():
		$TimerWaves.start(clamp(time_left - Waves[0][0], 0, time_left))
		time_left = time_left - clamp(time_left - Waves[0][0], 0, time_left)
	else:
		if !time_left:
			# End condition
			pass 
		else:
			$Timer3min.start(time_left)
