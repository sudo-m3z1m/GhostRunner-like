extends State

@export var camera_deviation_angle: float
@export var max_speed: float
@export_range(0, 1) var acceleration: float

var direction: Vector3

func enter_state(target: Player) -> void:
	super(target)

func update_state(delta: float) -> void:
	direction = state_machine.direction
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	
	target.velocity.x = lerp(target.velocity.x, direction.x * max_speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * max_speed, acceleration)
	
	rotate_camera()
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false

func rotate_camera() -> void:
	target.camera_pivot.rotation_degrees.x = \
	lerp(target.camera_pivot.rotation_degrees.x, direction.z * camera_deviation_angle, 0.1)
	target.camera_pivot.rotation_degrees.z = \
	lerp(target.camera_pivot.rotation_degrees.z, direction.x * camera_deviation_angle, 0.1)
