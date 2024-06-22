extends WeaponState

func enter_state(target: Weapon, state_machine: WeaponStateMachine) -> void:
	super(target, state_machine)
	target.freeze = false

func update_state(delta: float) -> void:
	print("ThrowState")

func exit_state() -> void:
	pass
