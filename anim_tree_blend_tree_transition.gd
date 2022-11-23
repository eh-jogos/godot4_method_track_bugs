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
	var current_state := 0
	
	if event.is_action_pressed("ui_cancel"):
		_use_anim_player = not _use_anim_player
		if _use_anim_player:
			_anim_tree.active = false
		else:
			_animator.stop()
			_anim_tree.active = true
			
		print("Using Animation Player? %s"%[_use_anim_player])
	
	if event.is_action_pressed("ui_up"):
		target_path = "method_at_4"
		current_state = 1
	elif event.is_action_pressed("ui_right"):
		target_path = "method_at_5"
		current_state = 2
	elif event.is_action_pressed("ui_down"):
		target_path = "method_at_6"
		current_state = 3
	elif event.is_action_pressed("ui_left"):
		target_path = "method_at_0.25s"
		current_state = 4
	
	
	if target_path != "":
		print("playing %s current_state: %s"%[target_path, current_state])
		if _use_anim_player:
			_animator.play(target_path)
		else:
			_anim_tree["parameters/Transition/current"] = current_state
			print("parameters/Transition/current: %s"%[_anim_tree["parameters/Transition/current"]])


func print_i_worked() -> void:
	print("I WORKED!")
