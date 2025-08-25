extends CharacterBody2D

@export var move_speed: float = 220.0
@export var jump_force: float = 430.0
@export var mirror: bool = false  # true = đảo ngược điều khiển

const GRAVITY: float = 1200.0

func _physics_process(delta: float) -> void:
	var dir := Input.get_axis("ui_left", "ui_right")
	if mirror:
		dir = -dir

	velocity.x = dir * move_speed

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = min(velocity.y, 0.0)

	move_and_slide()

	if has_node("Sprite2D"):
		var spr: Sprite2D = $Sprite2D
		spr.flip_h = velocity.x < 0
