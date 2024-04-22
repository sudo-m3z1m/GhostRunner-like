extends State

@export var jump_strength: float
@export var speed: float
@export_range(0, 1) var acceleration: float

var direction: Vector3
var prev_raycasts_states: Array[bool] = [false, false]

func enter_state(target: Player) -> void:
	super(target)
	target.velocity.y = jump_strength * clamp(target.jump_count, 0, 1)
	target.jump_count -= 1

func update_state(delta: float) -> void:
	direction = state_machine.direction
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	target.velocity.x = lerp(target.velocity.x, direction.x * speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * speed, acceleration)
	
	target.move_and_slide()
	
	if target.is_on_floor():
		accepted_states.append(StateMachine.STATES.IDLE)
		state_machine.change_state(StateMachine.STATES.IDLE)
		accepted_states.erase(StateMachine.STATES.IDLE)
	
	check_raycasts_collision()
	copy_raycasts_collisions()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false

func check_raycasts_collision() -> void:
	for raycast_index in target.raycasts.size():
		if target.raycasts[raycast_index].is_colliding() == prev_raycasts_states[raycast_index] or \
		target.raycasts[raycast_index].is_colliding() == false:
			continue
		state_machine.change_state(StateMachine.STATES.WALLRUN)

func copy_raycasts_collisions() -> void:
	for raycast_index in target.raycasts.size():
		prev_raycasts_states[raycast_index] = target.raycasts[raycast_index].is_colliding()
