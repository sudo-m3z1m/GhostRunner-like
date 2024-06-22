extends WeaponState

func enter_state(target: Weapon, state_machine: WeaponStateMachine) -> void:
	super(target, state_machine)
	target.freeze = true

func update_state(delta: float) -> void:
	print("Ready_state")

func exit_state() -> void:
	pass
