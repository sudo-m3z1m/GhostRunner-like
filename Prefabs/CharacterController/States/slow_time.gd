extends TimeState

@export_range(1, 5) var slow_time_ratio: float

func enter_state(target: Player) -> void:
	super(target)

func change_time() -> void:
	Engine.time_scale = default_time_scale / slow_time_ratio

func exit_state(next_state: StateMachine.STATES) -> bool:
	return true
