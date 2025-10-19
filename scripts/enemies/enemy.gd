extends CharacterBody2D

@export var SPEED = 50
@export var GRAVITY = 900
@export var TERMINAL_VELOCITY = 1000
@export var MAX_HP = 20
@export var DAMAGE = 3

@onready var ground_check = $GroundRayCast2D
@onready var wall_check = $WallRayCast2D
@onready var sprite = $Sprite2D

var direction = Vector2.RIGHT
var hp = MAX_HP

func _physics_process(delta):
	# gravity
	_apply_gravity(delta)

	# move
	velocity.x = direction.x * SPEED

	# do physics
	move_and_slide()

	# wall and edge detection
	_check_for_walls_and_cliffs()
	

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y = min(velocity.y + GRAVITY * delta, TERMINAL_VELOCITY)


func _check_for_walls_and_cliffs():
	if not ground_check.is_colliding() or wall_check.is_colliding():
		direction.x *= -1
		ground_check.target_position.x *= -1
		wall_check.target_position.x *= -1

		if sprite:
			sprite.flip_h = direction.x < 0


func take_damage(amount):
	hp -= amount
	print("Enemy HP:", hp)
	if hp <= 0:
		die()


func die():
	queue_free()
