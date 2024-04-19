extends Node

class_name AttackState

@export var animation: String

var target: Player
var attack_state: State
var animation_player: AnimationPlayer

func enter_state(target: Player, attack_state: State, animation_player: AnimationPlayer) -> void:
	self.target = target
	self.attack_state = attack_state
	self.animation_player = animation_player

func update_state(delta: float) -> void:
	pass

func exit_state() -> void:
	pass
