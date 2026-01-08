extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $AnimatedSprite2D
@export var grow_speed := 0.25
@export var shrink_speed := 0.6  
@export var min_scale := 0.7
@export var max_scale := 2.0 


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
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")
	move_and_slide()

func grow(factor: float):
	scale *= factor
	_change_size(factor, grow_speed)
	var tween = create_tween()
	tween.tween_property(self, "scale", scale, 1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

func shrink(factor: float):
	scale *= factor 
	_change_size(1.0 / factor, shrink_speed)
	var tween = create_tween()
	tween.tween_property(self, "scale", scale, 1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

func _change_size(multiplier: float, duration: float):
	var target_scale = scale * multiplier
	target_scale.x = clamp(target_scale.x, min_scale, max_scale)
	target_scale.y = clamp(target_scale.y, min_scale, max_scale)
	
	var tween = create_tween()
	
	tween.tween_property(self, "scale", target_scale, duration)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN_OUT)
