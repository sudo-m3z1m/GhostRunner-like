extends State

@export var jump_strength: float
@export var speed: float
@export_range(0, 1) var acceleration: float

var direction: Vector3

func enter_state(target: Player) -> void:
	super(target)
	if !target.is_on_floor():
		state_machine.change_state(StateMachine.STATES.IDLE)
		return
	target.velocity.y += jump_strength

func update_state(delta: float) -> void:
	direction = state_machine.direction
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	
	target.velocity.x = lerp(target.velocity.x, direction.x * speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * speed, acceleration)
	
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	return true
