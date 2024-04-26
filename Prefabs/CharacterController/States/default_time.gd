extends TimeState

func enter_state(target: Player) -> void:
	super(target)

func change_time() -> void:
	Engine.time_scale = default_time_scale

func exit_state(next_state: StateMachine.STATES) -> bool:
	return true
