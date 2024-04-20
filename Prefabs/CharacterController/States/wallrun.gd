extends State

@export_range(0, 1) var acceleration: float
@export var max_speed: float
@export var max_camera_rotation: float
@export var verticle_direction: float

var collided_raycast: RayCast3D
var direction: Vector3

func enter_state(target: Player) -> void:
	super(target)
	
	target.velocity.x = 0
	target.velocity.y = 0
	
	collided_raycast = get_collided_raycast()
	
	direction = Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y)
	direction.y = verticle_direction
	
	target.jump_count = target.max_jump_count
	target.gravity = 0
	animate_camera(true)

func update_state(delta: float) -> void:
	target.velocity.x = lerp(target.velocity.x, direction.x * max_speed, acceleration)
	target.velocity.z = lerp(target.velocity.z, direction.z * max_speed, acceleration)
	
	target.move_and_slide()
	
	if !collided_raycast.is_colliding():
		target.rotation = Vector3.ZERO
		state_machine.change_state(StateMachine.STATES.FALLING)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if next_state == StateMachine.STATES.JUMP:
		collided_raycast.enabled = false
		target.velocity += collided_raycast.get_collision_normal() * 40
	if is_next_state_valid(next_state):
		target.gravity = 1.2
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
