extends Area2D

var activated := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and not activated:
		activated = true
		CheckpointManager.set_checkpoint(global_position)
		print("Checkpoint set at:", global_position)
