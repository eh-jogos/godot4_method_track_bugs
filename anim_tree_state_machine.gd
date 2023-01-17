extends Node2D

@onready var _animator := $AnimationPlayer as AnimationPlayer
@onready var _anim_tree := $AnimationTree as AnimationTree
@onready var _anim_state_machine := _anim_tree.tree_root as AnimationNodeStateMachine 
@onready var _playback := _anim_tree["parameters/playback"] as AnimationNodeStateMachinePlayback

var _use_anim_player := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	var is_valid_path := false
	var target_path := ""
	
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
	elif event.is_action_pressed("ui_right"):
		target_path = "method_at_5"
	elif event.is_action_pressed("ui_down"):
		target_path = "method_at_6"
	elif event.is_action_pressed("ui_left"):
		if _use_anim_player:
			target_path = "method_at_0.25s"
		else:
			target_path = "method_at_025s"
	
	
	if target_path != "":
		print("playing %s"%[target_path])
		if _use_anim_player:
			_animator.play(target_path)
		else:
			var current_node_name := _playback.get_current_node()
			is_valid_path = _anim_state_machine.has_transition(current_node_name, target_path)
			if current_node_name == target_path:
				print("SAME")
				_playback.start(target_path)
			else:
				_playback.travel(target_path)
			


func print_i_worked() -> void:
	print("I WORKED!")


func _on_animation_player_animation_changed(old_name: StringName, new_name: StringName) -> void:
	print("old: %s, new: %s"%[old_name, new_name])


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("anim: %s"%[anim_name])


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	print("anim: %s"%[anim_name])
