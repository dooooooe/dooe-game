extends "res://scripts/characters/base_character.gd"

#@export var AIR_JUMP_FORCE = -150
#@export var AIR_JUMP_COOLDOWN = 0.1
#
#var air_jump_timer = 0
#
#func _handle_jump(delta):
	## coyote timer
	#if is_on_floor():
		#coyote_timer = COYOTE_TIME
	#else:
		#coyote_timer -= delta
		#
	## air jump timer
	#if air_jump_timer > 0:
		#air_jump_timer -= delta
		#
	## normal jump if on ground or coyote
	#if Input.is_action_pressed("move_up") and coyote_timer > 0:
		#velocity.y = JUMP_FORCE
		#is_jumping = true
		#jump_timer = 0
		#coyote_timer = 0
		#
	## otherwise air jump
	#elif Input.is_action_just_pressed("move_up") and air_jump_timer <= 0:
		#velocity.y = AIR_JUMP_FORCE
		#air_jump_timer = AIR_JUMP_COOLDOWN
		#is_jumping = true
		#jump_timer = 0
		#coyote_timer = 0
	#
	## hold for bigger jump
	#if is_jumping:
		#if Input.is_action_pressed("move_up") and jump_timer < MAX_JUMP_TIME:
			#velocity.y = JUMP_FORCE
			#jump_timer += delta
			#
		#else:
			#jump_timer = 0
			#is_jumping = false
