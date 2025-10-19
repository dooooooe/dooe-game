extends Camera2D

@export var MIN_ZOOM = Vector2(0.5, 0.5)
@export var MAX_ZOOM = Vector2(2, 2)
@export var ZOOM_STEP = 0.1

# drag and drop character manager in inspector to make camera follow the characters
@export var char_manager: CharacterManager

func _input(event):
	if not Globals.DEBUG:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom -= Vector2(ZOOM_STEP, ZOOM_STEP)
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom += Vector2(ZOOM_STEP, ZOOM_STEP)
		
		zoom.x = clamp(zoom.x, MIN_ZOOM.x, MAX_ZOOM.x)
		zoom.y = clamp(zoom.y, MIN_ZOOM.y, MAX_ZOOM.y)


func _process(_delta):
	if char_manager:
		var active_char = char_manager.get_active_character()
		if active_char:
			global_position = active_char.global_position
