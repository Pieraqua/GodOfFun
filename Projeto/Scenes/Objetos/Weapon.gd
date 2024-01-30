extends Node2D

const ATK = 5
const RELOAD = 0.5

@onready var start_pos_y = $AnimatedSprite2D.position.y  

func _ready():
	$ReloadTimer.timeout.connect(_on_animation_finish)
	set_flip(false)

func set_flip(val : bool):
	$AnimatedSprite2D.scale.y = -1*int(val) + 1*int(not val)
	$AnimatedSprite2D.position.y = -start_pos_y*int(val) + start_pos_y*int(not val)

func hit():
	if($ReloadTimer.is_stopped()):
		$AnimatedSprite2D.play()
		$AnimatedSprite2D/Hitbox/HitboxPrincipal/HitboxIndicator.set_visible(true)
		$ReloadTimer.start(RELOAD)
		for body in $AnimatedSprite2D/Hitbox.get_overlapping_bodies():
			if body.has_method("hit"):
				body.hit(ATK)

func _on_animation_finish():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D/Hitbox/HitboxPrincipal/HitboxIndicator.set_visible(false)
	
