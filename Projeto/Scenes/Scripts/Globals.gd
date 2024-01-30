extends Node

var player
enum MONSTER_TYPES {BASIC, BOSS}
@onready var point_system = $Pontos
@onready var ui = $UI

func _ready():
	pass

func get_ui():
	return ui

# Vetor com os dados de cada monstro
# [ Points, Combo, HP, ATK ] 
var monsters = [
	# Basic
	[ 5, 1, 5, 1 ],
	# Boss
	[ 500, 10, 500, 10 ]
]
