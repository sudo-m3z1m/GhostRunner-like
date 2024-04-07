extends Node

class_name StateMachine

enum STATES {
	IDLE,
	MOVING,
	JUMP
}

@onready var player: Player = get_parent()
@onready var states: Dictionary = {
	STATES.IDLE: $Idle,
	STATES.MOVING: $Moving,
	STATES.JUMP: $Jump
}

@export var start_state: STATES

var current_state: State

func _ready() -> void:
	current_state = states[start_state]

func change_state(new_state: STATES) -> void:
	if states[new_state] == current_state or !current_state.exit_state(new_state):
		return
	current_state = states[new_state]
	current_state.enter_state(player)
