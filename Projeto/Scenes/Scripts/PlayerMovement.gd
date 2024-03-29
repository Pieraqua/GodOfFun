extends CharacterBody2D

const SPEED = 300.0
const MAX_HP = 100

var hitpoints = MAX_HP
var damage_sources : Array[float] = []

var weapon_pos_y = 0

@onready var Globals = get_node("/root/MainScene")

func _ready():
	Globals.set("player", self)
	hitpoints = MAX_HP
	
	var UI = Globals.get_ui()
	if UI == null:
		print("Player - UI_HP nao encontrado")
	if UI:
		UI.update_hp(hitpoints)
		
	if $WeaponHolster.get_child(0) != null and \
		 $WeaponHolster.get_child(0).get_child(0) != null and \
			 $WeaponHolster.get_child(0).get_child(0).get_class() == "AnimatedSprite2D":
				weapon_pos_y = $WeaponHolster.get_child(0).get_child(0).position.y
	
	$AnimatedSprite2D.play("idle")

func _process(delta):
	if !damage_sources.is_empty():
		hitpoints -= damage_sources.max()*delta
		var UI = Globals.get_ui()
		if UI:
			UI.update_hp(hitpoints)
		if hitpoints < 0:
			print("Fim de jogo!")
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if direction:
		velocity = direction * SPEED
		if direction.x > 0:
			$AnimatedSprite2D.play("run_right")
		elif direction.x < 0:
			$AnimatedSprite2D.play("run_left")
		elif direction.y > 0:
			$AnimatedSprite2D.play("run_forward")
		elif direction.y < 0:
			$AnimatedSprite2D.play("run_back")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	
	if $WeaponHolster != null:
		$WeaponHolster.rotation = mouse_direction.angle()
		if $WeaponHolster.rotation > 1.5 or $WeaponHolster.rotation < -1.5  \
			and $WeaponHolster.get_child(0).has_method("set_flip") \
			and  $WeaponHolster.get_child(0) != null:
				$WeaponHolster.get_child(0).set_flip(true)
		elif $WeaponHolster.get_child(0) != null \
			and $WeaponHolster.get_child(0).has_method("set_flip") :
				$WeaponHolster.get_child(0).set_flip(false)
	move_and_slide()


func _on_area_2d_body_entered(body):
	var is_enemy = body.get_collision_layer() & 2
	
	if is_enemy:
		damage_sources.append(body.ATK)
		print("Taking damage from new source: " + str(body.ATK))


func _on_area_2d_body_exited(body):
	if body.ATK in damage_sources:
		print("Stopped taking damage from: " + str(body.ATK))
		damage_sources.erase(body.ATK)

func _input(event):
	if event.is_action_pressed("attack"):
		if $WeaponHolster.get_child(0).has_method("hit"):
			$WeaponHolster.get_child(0).hit()


