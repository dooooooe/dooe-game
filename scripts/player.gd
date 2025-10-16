extends CharacterBody2D

const SPEED = 150
const GRAVITY = 900
const JUMP_FORCE = -200
const MAX_JUMP_TIME = 0.1

var jump_timer = 0.0
var is_jumping = false

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
	if Input.is_action_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		
	if is_jumping:
		if Input.is_action_pressed("move_up") and jump_timer < MAX_JUMP_TIME:
			velocity.y = JUMP_FORCE
			jump_timer += delta
			
		else:
			jump_timer = 0
			is_jumping = false

	# do physics stuff
	move_and_slide()
