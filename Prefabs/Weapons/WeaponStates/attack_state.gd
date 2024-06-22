extends WeaponState

func enter_state(target: Weapon, state_machine: WeaponStateMachine) -> void:
	super(target, state_machine)

func update_state(delta: float) -> void:
	pass

func exit_state() -> void:
	pass
