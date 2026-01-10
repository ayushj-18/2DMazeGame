extends Area2D

var checkpoint_manager
var player

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()
		return
