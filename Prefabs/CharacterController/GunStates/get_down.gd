extends GunState

func enter_state(target: Player) -> void:
	super(target)
	animation_player.play_backwards(animation)
	state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)

func state_exit(next_state: Gun.GUN_STATES) -> bool:
	return true
