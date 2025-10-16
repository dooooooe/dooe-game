extends CharacterBody2D

@export var SPEED = 150
@export var JUMP_FORCE = -200
@export var GRAVITY = 900
@export var MAX_JUMP_TIME = 0.1
@export var COYOTE_TIME = 0.1

var is_jumping = false
var jump_timer = 0.0
var coyote_timer = COYOTE_TIME

func _physics_process(delta):
	# reset (debug)
	if Globals.DEBUG and Input.is_key_pressed(KEY_R):
		global_position = Vector2(0, 0)
	
	# gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# left right inputs
	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * SPEED

	# yump
	_handle_jump(delta)

	# do physics stuff
	move_and_slide()


func _handle_jump(delta):
	# coyote timer
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta
	
	# jump if on ground or coyoteing
	if Input.is_action_pressed("move_up") and coyote_timer > 0:
		velocity.y = JUMP_FORCE
		is_jumping = true
		jump_timer = 0
		coyote_timer = 0
	
	# hold for bigger jump
	if is_jumping:
		if Input.is_action_pressed("move_up") and jump_timer < MAX_JUMP_TIME:
			velocity.y = JUMP_FORCE
			jump_timer += delta
			
		else:
			jump_timer = 0
			is_jumping = false


func sync_with(character: CharacterBody2D):
	global_position = character.global_position
	velocity = character.velocity


func activate():
	visible = true
	set_physics_process(true)
	velocity = Vector2.ZERO

	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = false


func deactivate():
	visible = false
	set_physics_process(false)
	velocity = Vector2.ZERO

	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = true
