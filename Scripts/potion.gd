extends Area2D

@export var shrink_factor := 0.1

func _on_body_entered(body):
	body.shrink(shrink_factor)
	queue_free()
