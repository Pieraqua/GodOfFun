extends Node

class_name SistemaDeWave

@onready var globals = get_node("/root/MainScene")

var Waves : Array[Array] = [
	[5, "res://Scenes/Waves/Wave_2.tscn"],
	[5, "res://Scenes/Waves/Wave_1.tscn"],
	[5, "res://Scenes/Waves/Wave_2.tscn"],
	[5, "res://Scenes/Waves/Wave_1.tscn"],
	[5, "res://Scenes/Waves/Wave_2.tscn"],
	[5, "res://Scenes/Waves/Wave_3.tscn"],
	[5, "res://Scenes/Waves/Wave_4.tscn"],
	[5, "res://Scenes/Waves/Wave_5.tscn"],
	[5, "res://Scenes/Waves/Wave_6.tscn"],
	[5, "res://Scenes/Waves/Wave_7.tscn"],
	[5, "res://Scenes/Waves/Wave_8.tscn"],
	[5, "res://Scenes/Waves/Wave_9.tscn"],
	[5, "res://Scenes/Waves/Wave_10.tscn"],
	[5, "res://Scenes/Waves/Wave_10.tscn"]
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
	$TimerWaves.start(Waves[0][0])
	
func _update_time():
	globals.get("ui").update_timer($TimerJogo.time_left)
	pass
	
func _time_over():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	pass

func _on_timer_end():
	emit_signal("spawn_wave", Waves[0][1])
	Waves.erase(Waves[0])
	
	if !Waves.is_empty():
		$TimerWaves.start(Waves[0][0])
	else:
		$Timer3min.start(time_left)
