extends State

@export_range(0, 1) var inertia: float

func enter_state(target: Player) -> void:
	super(target)
	target.jump_count = target.max_jump_count

func update_state(delta: float) -> void:
	target.velocity.x = lerp(target.velocity.x, 0.0, inertia)
	target.velocity.z = lerp(target.velocity.z, 0.0, inertia)
	
	target.camera_pivot.rotation = lerp(target.camera_pivot.rotation, Vector3.ZERO, 0.1)
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false
