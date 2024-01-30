extends Node

var player
enum MONSTER_TYPES {BASIC, BOSS}
var point_system

func _ready():
	point_system = $Pontos

# Vetor com os dados de cada monstro
# [ Points, Combo, HP, ATK ] 
var monsters = [
	# Basic
	[ 5, 1, 5, 1 ],
	# Boss
	[ 500, 10, 500, 10 ]
]
