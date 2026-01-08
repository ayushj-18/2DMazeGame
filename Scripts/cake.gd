extends Area2D

@export var growth_factor := 1.5

func _on_body_entered(body):
	body.grow(growth_factor)
	queue_free()
