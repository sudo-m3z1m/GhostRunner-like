extends GunState

func enter_state(target: Player) -> void:
	super(target)
	animation_player.queue(animation)
	gun.current_ammo_count = gun.max_ammo_count

func state_exit(next_state: Gun.GUN_STATES) -> bool:
	if next_state == Gun.GUN_STATES.GET_UP:
		gun.change_state(Gun.GUN_STATES.GET_DOWN)
		return false
	return true
