extends State

class_name GunState

var gun: Gun

func enter_state(target: Player) -> void:
	self.target = target
	gun = get_parent()
	state_machine = target.state_machine
	animation_player = gun.animation_player

func update_state(delta: float) -> void:
	pass

func state_exit(next_state: Gun.GUN_STATES) -> bool:
	return true
