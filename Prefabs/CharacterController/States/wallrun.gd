extends State

@export_range(0, 1) var acceleration: float
@export var max_speed: float
@export var max_camera_rotation: float

var collided_raycast: RayCast3D
var direction: Vector3

func enter_state(target: Player) -> void:
	super(target)
	
	target.velocity.x = 0
	target.velocity.y = 0
	
	collided_raycast = get_collided_raycast()
	target.rotation.y = collided_raycast.get_collision_normal().y
	
	direction = Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y)
	target.gravity = 0
	animate_camera(true)

func update_state(delta: float) -> void:
	target.velocity.x = lerp(target.velocity.x, direction.x * max_speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * max_speed, acceleration)
	
	target.move_and_slide()
	
	if !collided_raycast.is_colliding():
		target.gravity = 1.2
		target.rotation = Vector3.ZERO
		state_machine.change_state(StateMachine.STATES.FALLING)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		animate_camera(false)
		return true
	return false

func get_collided_raycast() -> RayCast3D:
	for raycast in target.raycasts:
		if !raycast.is_colliding():
			continue
		return raycast

	return null

func animate_camera(is_on_wall: bool) -> void:
	var tween: Tween = create_tween()
	var rotate_direction: Vector3 = collided_raycast.target_position
	tween.tween_property(target.camera, "rotation_degrees:z", rotate_direction.x * max_camera_rotation * int(is_on_wall), 0.1)
