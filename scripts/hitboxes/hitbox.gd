extends Area2D

var team = 'team_neutral'

func _ready() -> void:
	owner = get_parent()
	inherit_team()


func inherit_team():
	for group in owner.get_groups():
		if group.begins_with('team_'):
			team = group


func do_damage_to_owner(damage): # hurtboxes will call this function
	owner.take_damage(damage)
