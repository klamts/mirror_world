# scripts/Level1.gd
extends Node2D

var reached := {
	"Player": false,
	"MirrorPlayer": false
}

func _ready() -> void:
	# Kết nối tín hiệu từ hai Goal
	$GoalLeft.reached.connect(_on_goal_reached)
	$GoalRight.reached.connect(_on_goal_reached)

	# Đảm bảo 2 nhân vật thuộc group "players" (phòng trường hợp quên set trong editor)
	$Player.add_to_group("players")
	$MirrorPlayer.add_to_group("players")

func _on_goal_reached(body_name: String) -> void:
	if reached.has(body_name):
		reached[body_name] = true
	if reached["Player"] and reached["MirrorPlayer"]:
		_win()

func _win() -> void:
	$CanvasLayer/WinLabel.text = "Level Complete!"
	await get_tree().create_timer(1.0).timeout
	# Sau 1s có thể chuyển level khác; tạm thời reload để demo
	get_tree().reload_current_scene()
