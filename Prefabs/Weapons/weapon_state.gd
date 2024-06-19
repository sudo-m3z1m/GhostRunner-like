class_name WeaponState
extends RefCounted

var target: Weapon
var target_animation_player: AnimationPlayer
var state_machine: WeaponStateMachine

func enter_state(target: Weapon, state_machine: WeaponStateMachine) -> void:
	self.target = target
	self.state_machine = state_machine
	target_animation_player = target.animation_player

func update_state(delta: float) -> void:
	pass

func exit_state() -> void:
	pass
