extends CharacterBody2D

@onready var bullet = preload("res://Bullet.tscn")
const GRAVITY = 500.0
const WALK_SPEED = 150
const BASE_JUMP_POWER = 150
const MAX_JUMP_TIME: float = 0.5
var jumptimer: float = 0.0
var direction = Vector2.ZERO

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_key_pressed(KEY_A):
		velocity.x = -WALK_SPEED
		$Marker2D.position.x = -23
		$Sprite2D.flip_h = true
	elif Input.is_key_pressed(KEY_D):
		velocity.x =  WALK_SPEED
		$Marker2D.position.x = 24
		$Sprite2D.flip_h = false
	else:	
		velocity.x = 0
	
	if is_on_floor():
		jumptimer = 0.0
	if (Input.is_action_just_pressed("ui_up") && is_on_floor()):
		jumptimer = 0.0
	if (Input.is_key_pressed(KEY_W) && jumptimer < MAX_JUMP_TIME):
		jumptimer += delta
		var jump_height = BASE_JUMP_POWER * (1.0 - jumptimer / MAX_JUMP_TIME)
		velocity.y = -jump_height
	
	velocity.y += delta * GRAVITY
	shoot($Sprite2D.flip_h)
	move_and_slide()

func shoot(dir):
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instantiate()
		b.init(dir)
		get_parent().add_child(b)
		b.global_position= $Marker2D.global_position
func _ready():
	pass


