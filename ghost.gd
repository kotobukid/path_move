extends Node2D
var next_pos: Vector2 = Vector2()

func _ready():
	$WindWayPath/AnimationPlayer.play("move_wind")

func __start_move():
	var bodyRoot = get_node("WindWayPath/PathFollow2D/GhostBodyRoot")
	var global_rotation_ = bodyRoot.global_rotation
	
	var display_boundary = bodyRoot.get_node("DisplayBoundary")
	display_boundary.rotation = global_rotation_ * -2

func start_move():
	var bodyRoot = get_node("WindWayPath/PathFollow2D/GhostBodyRoot")
	var display_boundary = bodyRoot.get_node("DisplayBoundary")
	display_boundary.global_rotation = 0

func commit_move():
	var pos = get_node("WindWayPath/PathFollow2D/GhostBodyRoot").global_position
	next_pos = pos
	call_deferred("commit_move_deferred")


func commit_move_deferred():
	$WindWayPath/PathFollow2D.progress_ratio = 0	
	position = next_pos
	# position = pos
