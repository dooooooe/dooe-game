extends Node

@onready var characters = [$Square, $Triangle]
var current_index = 0

func _ready():
	for i in range(characters.size()):
		if i == current_index:
			characters[i].activate()

		else:
			characters[i].deactivate()

func _process(_delta):
	if Input.is_action_just_pressed("swap_character"):
		swap_character()

func swap_character():
	var old_char = characters[current_index]
	current_index = (current_index + 1) % characters.size()
	var new_char = characters[current_index]

	new_char.sync_with(old_char)

	old_char.deactivate()
	new_char.activate()
