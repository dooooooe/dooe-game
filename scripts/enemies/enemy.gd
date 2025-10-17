extends CharacterBody2D

@export var SPEED = 50
@export var GRAVITY = 900

@onready var ground_check = $GroundRayCast2D
@onready var wall_check = $WallRayCast2D
@onready var sprite = $Sprite2D

var direction = Vector2.RIGHT

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# move
	velocity.x = direction.x * SPEED

	# do physics
	move_and_slide()

	# wall and edge detection
	if not ground_check.is_colliding() or wall_check.is_colliding():
		direction.x *= -1
		ground_check.target_position.x *= -1
		wall_check.target_position.x *= -1

		if sprite:
			sprite.flip_h = direction.x < 0
