extends Camera2D

const MIN_ZOOM = Vector2(0.5, 0.5)
const MAX_ZOOM = Vector2(2, 2)
const ZOOM_STEP = 0.1

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
