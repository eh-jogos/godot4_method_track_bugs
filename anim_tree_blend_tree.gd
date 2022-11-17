extends Node2D

@onready var _animator := $AnimationPlayer as AnimationPlayer
@onready var _anim_tree := $AnimationTree as AnimationTree

var _use_anim_player := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	var is_valid_path := false
	var target_path = ""
	
	if event.is_action_pressed("ui_cancel"):
		_use_anim_player = not _use_anim_player
		if _use_anim_player:
			_anim_tree.active = false
		else:
			_animator.stop()
			_anim_tree.active = true
			
		print("Using Animation Player? %s"%[_use_anim_player])
	
	if event.is_action_pressed("ui_up"):
		if _use_anim_player:
			target_path = "method_at_4"
		else:
			target_path = "4frames"
	elif event.is_action_pressed("ui_right"):
		if _use_anim_player:
			target_path = "method_at_5"
		else:
			target_path = "5frames"
	elif event.is_action_pressed("ui_down"):
		if _use_anim_player:
			target_path = "method_at_6"
		else:
			target_path = "6frames"
	elif event.is_action_pressed("ui_left"):
		if _use_anim_player:
			target_path = "method_at_0.25s"
		else:
			target_path = "reset"
	
	
	if target_path != "":
		print("playing %s"%[target_path])
		if _use_anim_player:
			_animator.play(target_path)
		else:
			_anim_tree["parameters/Transition/current"] = target_path
			print("parameters/Transition/current: %s"%[_anim_tree["parameters/Transition/current"]])


func print_i_worked() -> void:
	print("I WORKED!")
