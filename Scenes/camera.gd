extends Camera2D

@export var min_zoom := 0.7
@export var max_zoom := 2.0 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mousewheel_down"):
		if get_zoom() > Vector2(0.5,0.5):
			set_zoom(get_zoom() - Vector2(0.1,0.1))
		return
			
	if event.is_action_pressed("mousewheel_up"):
		if get_zoom() > Vector2(0.5,0.5):
			set_zoom(get_zoom() + Vector2(0.1,0.1))
		return

func _zoom(amount: float):
	var new_zoom = Camera2D.zoom + Vector2(amount, amount)
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	Camera2D.zoom = new_zoom
