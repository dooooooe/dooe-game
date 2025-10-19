extends Area2D

var team = 'team_neutral'
var DAMAGE = 1

func _ready() -> void:
	owner = get_parent()
	inherit_team()
	inherit_damage()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox") and area.owner != owner: # only detect hitboxes not owned by self
		if area.team != team or team == 'team_neutral': # only do damage to hitboxes from opposing teams
			print("ouch!")
			area.do_damage_to_owner(DAMAGE)


func inherit_team():
	for group in owner.get_groups():
		if group.begins_with('team_'):
			team = group


func inherit_damage():
	if "DAMAGE" in owner:
		DAMAGE = owner.DAMAGE
	
