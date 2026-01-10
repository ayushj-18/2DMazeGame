extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	print("You died!")
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
