extends Area2D

func _ready() -> void:
	owner = get_parent()

func do_damage_to_owner(damage):
	owner.take_damage(damage)
