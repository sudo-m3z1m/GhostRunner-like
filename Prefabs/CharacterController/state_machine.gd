extends Node

class_name StateMachine

enum STATES {
	IDLE,
	MOVING,
	JUMP,
	FALLING,
	DASH,
	WALLRUN,
	ATTACK,
	DEFAULT_TIME,
	SLOWED_TIME
}

@onready var player: Player = get_parent()
@onready var states: Dictionary = {
	STATES.IDLE: $Idle,
	STATES.MOVING: $Moving,
	STATES.JUMP: $Jump,
	STATES.FALLING: $Falling,
	STATES.DASH: $Dash,
	STATES.WALLRUN: $WallRun,
	STATES.ATTACK: $Attack
}

@export var start_state: STATES

var current_state: State = State.new()
var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	change_state(start_state)

func _physics_process(delta: float) -> void:
	current_state.update_state(delta)

func change_state(new_state: STATES) -> void:
	if states[new_state] == current_state or !current_state.exit_state(new_state):
		return
	current_state = states[new_state]
	current_state.enter_state(player)
