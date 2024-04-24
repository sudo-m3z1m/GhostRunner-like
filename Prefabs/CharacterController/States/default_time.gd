extends TimeState

func enter_state(target: Player) -> void:
	super(target)

func change_time() -> void:
	Engine.time_scale = default_time_scale
	animation_player.play_backwards(animation)

func shoot() -> void:
	state_machine.change_time_state(StateMachine.STATES.SLOWED_TIME)
	state_machine.shoot()

func exit_state(next_state: StateMachine.STATES) -> bool:
	return true
