extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		print("ouch!")
		area.do_damage_to_owner(3)
