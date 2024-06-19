class_name WeaponState
extends RefCounted

var target: Weapon
var target_animation_player: AnimationPlayer
var state_machine: WeaponsStateMachine

func enter_state(target: Weapon, state_machine: WeaponsStateMachine) -> void:
	self.target = target
	self.state_machine = state_machine
	target_animation_player = target.animation_player
