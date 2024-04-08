extends Node

class_name State

@export var animation: String
@export var accepted_states: Array[StateMachine.STATES]

var state_machine: StateMachine
var target: Player

func enter_state(target: Player) -> void:
	self.target = target
	state_machine = get_parent()

func update_state(delta: float) -> void:
	pass

func exit_state(next_state: StateMachine.STATES) -> bool:
	return true

func is_next_state_valid(next_state: StateMachine.STATES) -> bool:
	for state in accepted_states:
		if next_state == state:
			return true
	return false
