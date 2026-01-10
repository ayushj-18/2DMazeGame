extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $Sprite
@export var grow_speed := 0.25
@export var shrink_speed := 0.6  
@export var base_gravity := 1200.0
@export var gravity_scale := 1.0
@export var current_gravity := 1200

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if animated_sprite:
			animated_sprite.play("walk")
		if animated_sprite:
			animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if animated_sprite:
			animated_sprite.play("idle")
	move_and_slide()

func grow(factor: float):
	scale *= factor
	var tween = create_tween()
	tween.tween_property(self, "scale", scale, 1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	scale = Vector2.ONE * 1.6
	gravity_scale = 1.4
	update_gravity()

func shrink(factor: float):
	scale *= factor 
	var tween = create_tween()
	tween.tween_property(self, "scale", scale, 1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	scale = Vector2.ONE * 0.6
	gravity_scale = 0.6
	update_gravity()

func update_gravity():
	current_gravity = base_gravity * gravity_scale

func respawn():
	if CheckpointManager.has_checkpoint:
		global_position = CheckpointManager.get_respawn_position()
	else:
		global_position = Vector2(100, 100) # spawn point
		
func die():
	if is_in_group("player"):
		velocity = Vector2.ZERO
		if CheckpointManager.has_checkpoint:
			global_position = CheckpointManager.get_respawn_position()
		else:
			global_position = Vector2(100, 100) # fallback spawn
		reset_state()

func reset_state():
	animated_sprite.play("idle")
