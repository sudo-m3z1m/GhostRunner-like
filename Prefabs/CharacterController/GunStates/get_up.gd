extends GunState

func enter_state(target: Player) -> void:
	super(target)
	state_machine.change_time_state(StateMachine.STATES.SLOWED_TIME)
	animation_player.queue(animation)

func state_exit(next_state: Gun.GUN_STATES) -> bool:
	if next_state == Gun.GUN_STATES.GET_UP:
		gun.change_state(Gun.GUN_STATES.GET_DOWN)
		return false
	return true
