extends TimeState

@export_range(1, 5) var slow_time_ratio: float
@export var shoot_animation: String

func enter_state(target: Player) -> void:
	super(target)

func change_time() -> void:
	Engine.time_scale = default_time_scale / slow_time_ratio
	animation_player.play(animation)

func shoot() -> void:
	animation_player.play(shoot_animation)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if !(is_next_state_valid(next_state)):
		return true
	state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)
	return false
