extends State

@export var camera_deviation_angle: float
@export var max_speed: float
@export_range(0, 1) var acceleration: float

var direction: Vector3

func enter_state(target: Player) -> void:
	super(target)
	animation_player.play(animation)
	
	var particles_position: Vector3
	particles_position = target.global_position
	particles_position.y -= 1
	target.particles_component.show_particle(particles_position)

func update_state(delta: float) -> void:
	target.is_falling()
	direction = state_machine.direction
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)

	target.velocity.x = lerp(target.velocity.x, direction.x * max_speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * max_speed, acceleration)

	rotate_camera()
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		animation_player.stop()
		return true
	return false

func rotate_camera() -> void:
	#target.camera.rotation_degrees.x = \
	#lerp(target.camera.rotation_degrees.x, new_camera_degrees_x, 0.1)
	target.camera.rotation_degrees.z = \
	lerp(target.camera.rotation_degrees.z, state_machine.direction.x * camera_deviation_angle, 0.1)
