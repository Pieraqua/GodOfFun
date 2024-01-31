extends Node

class_name SistemaDeWave

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

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer3min.start(300)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for wave in Waves:
		if wave[0] > $Timer3min.get_time_left():
			emit_signal("spawn_wave", wave[1])
			Waves.erase(wave)
