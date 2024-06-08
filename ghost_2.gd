extends Node2D

var move_committing: bool = false
var next_pos_offset: Vector2 = Vector2(0, 0)
@export var current_route_path: Path2D

func _ready():
	target_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move_committing:
		move_committing = false
		position += next_pos_offset
		
		$AnimationPlayer.play("move_wind")
	else:
		var a_pos = current_route_path.get_node("PathFollow2D/Marker2D").global_position
		var b_pos = $PathGroup.global_position
		var delta_pos = a_pos - b_pos
		$DisplayRoot.position = delta_pos


func target_rotation():
	var player =  get_tree().root.get_node("World/Player")
	
	var vector1 = position
	var vector2 = player.position

	# ２つのベクトル間の差を計算
	var diff = vector2 - vector1

	# 角度を計算（ラジアン単位）
	var angle = atan2(diff.y, diff.x)

	# 角度を度単位に変換する場合（オプション）
	var angle_degrees = rad_to_deg(angle)
	$PathGroup.rotation_degrees = angle_degrees + 180
	$AnimationPlayer.play("move_wind")
	
	var paths = [$PathGroup/Path2D_A, $PathGroup/Path2D_B]  # 用意したPath2Dの配列
	var chosen_path = paths[randi() % paths.size()]  # ランダムに一つ選択
	current_route_path = chosen_path

	if diff.x > 0:
		$DisplayRoot/GhostPic.flip_h = true
	else:
		$DisplayRoot/GhostPic.flip_h = false

func commit_move():
	$AnimationPlayer.stop()
	move_committing = true
	next_pos_offset = $DisplayRoot.position
	$DisplayRoot.position = Vector2(0, 0)

