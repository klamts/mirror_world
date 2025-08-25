# scripts/Goal.gd
extends Area2D

signal reached(body_name: String)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Chỉ chấp nhận Player/MirrorPlayer
	if body.is_in_group("players"):
		reached.emit(body.name)
