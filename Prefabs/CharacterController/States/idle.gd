extends State

@export_range(0, 1) var inertia: float

func enter_state(target: Player) -> void:
	super(target)

func update_state(delta: float) -> void:
	target.velocity.x = lerp(target.velocity.x, 0.0, inertia)
	target.velocity.z = lerp(target.velocity.z, 0.0, inertia)
	
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false
