extends CharacterBody2D

@export var SPEED = 150
@export var JUMP_FORCE = -200
@export var GRAVITY = 900
@export var TERMINAL_VELOCITY = 1000
@export var MAX_JUMP_TIME = 0.3
@export var COYOTE_TIME = 0.1
@export var MAX_HP = 20

var is_jumping = false
var extra_jump = false
var jump_timer = 0.0
var coyote_timer = COYOTE_TIME

var hp = MAX_HP

func _physics_process(delta):
	# reset (debug)
	if Globals.DEBUG and Input.is_key_pressed(KEY_R):
		global_position = Vector2(0, 0)
	
	# gravity
	_apply_gravity(delta)
	
	# left right inputs
	_handle_horizontal_input(delta)

	# yump
	_handle_jump(delta)

	# do physics stuff
	move_and_slide()


func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y = min(velocity.y + GRAVITY * delta, TERMINAL_VELOCITY)


func _handle_horizontal_input(delta):
	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * SPEED


func _handle_jump(delta):
	# coyote timer
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta
	
	# jump if on ground or coyoteing
	if (Input.is_action_pressed("move_up") and coyote_timer > 0) or (Input.is_action_just_pressed("move_up") and extra_jump):
		velocity.y = JUMP_FORCE
		is_jumping = true
		extra_jump = false
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

	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = false
			
	extra_jump = true


func deactivate():
	visible = false
	set_physics_process(false)
	velocity = Vector2.ZERO

	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = true
