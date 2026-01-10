extends Node

var respawn_position: Vector2
var has_checkpoint := false

func set_checkpoint(pos: Vector2):
	respawn_position = pos
	has_checkpoint = true

func get_respawn_position() -> Vector2:
	return respawn_position
	
