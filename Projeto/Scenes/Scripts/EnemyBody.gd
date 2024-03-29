extends CharacterBody2D

class_name Enemy

@export var SPEED : float = 100.0
@export var ATK : float = 5
@export var HP_MAX : float = 10

var current_knockback = 0
var knockback_dir = Vector2(0,0)
var initial_knockback = 0

@export var POINT_VALUE = 5
@export var COMBO_RAISE = 1

var hitpoints = HP_MAX
var dead = false

@onready var globals = get_node("/root/MainScene")

# death animation frames and fps
@export var N_FRAMES = 17.0
@export var FPS = 10.0

func _ready():
	$AnimatedSprite2D.play("walk")
	$DeathTimer.timeout.connect(really_die)
	

func die():
	remove_child($CollisionShape2D)
	$AnimatedSprite2D.play("defeat")
	$DeathTimer.start(N_FRAMES/FPS)
	dead = true
	velocity = Vector2(0,0)
	
	var point_system = globals.get("point_system")
	
	if point_system and point_system.has_method("on_monster_killed"):
		point_system.on_monster_killed(POINT_VALUE, COMBO_RAISE)
	
func really_die():
	get_parent().remove_child(self)
	
	
func hit(damage : int, knockback : int) -> void:
	current_knockback += knockback
	initial_knockback = knockback
	knockback_dir = -(global_position.direction_to(globals.get("player").global_position)).normalized()
	if(hitpoints <= damage):
		die()
	else:
		hitpoints -= damage

func _process(_delta):
	var viewport_size = get_viewport_rect().size
	var show_arrow = false
	var arrow_pos = get_viewport_rect().size/2 +  global_position - globals.get("player").global_position
	
	# Flecha para a direita
	if(arrow_pos.x > viewport_size.x - 4 * 
		$AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().x):
		arrow_pos.x = viewport_size.x - $CanvasLayer/Frecha.get_rect().size.x + 10
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(90)
	# Flecha para a esquerda
	if(arrow_pos.x < 4 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().x):
		arrow_pos.x = 0 + 4
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(-90)
	# Flecha para baixo
	if(arrow_pos.y > viewport_size.y - 
		2 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().y):
		arrow_pos.y = viewport_size.y - 4#- $CanvasLayer/Frecha.get_rect().size.y
		$CanvasLayer/Frecha.set_rotation_degrees(180)
		
		show_arrow = true
	# Flecha para cima
	if(arrow_pos.y < 2 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().y):
		arrow_pos.y = 0 + 4
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(0)
	
	if show_arrow:
		$CanvasLayer/Frecha.position = arrow_pos
	else:
		$CanvasLayer/Frecha.position = get_viewport_rect().size
	pass

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = global_position.direction_to(globals.get("player").global_position)
	if current_knockback:
		velocity = (knockback_dir * SPEED * current_knockback * _delta)
		current_knockback -= (velocity*_delta).length()
		if velocity.length() < initial_knockback:
			current_knockback = 0
		
	elif direction and !dead:
		velocity = direction * SPEED
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
	move_and_slide()
