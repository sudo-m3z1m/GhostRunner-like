extends State

func enter_state(target: Player) -> void:
	super(target)

func update_state(delta: float) -> void:
	pass

func exit_state(next_state: StateMachine.STATES) -> bool:
	return false
