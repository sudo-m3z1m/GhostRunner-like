extends TimeState

@export_range(1, 5) var slow_time_ratio: float
@export var shoot_animation: String

var gun: Node3D
var shot_raycast: RayCast3D

func enter_state(target: Player) -> void:
	super(target)
	gun = target.camera.get_node("shotgun_placeholder")
	shot_raycast = target.camera.get_node("ShotRaycast")
	current_bullets_count = max_bullets_count

func change_time() -> void:
	Engine.time_scale = default_time_scale / slow_time_ratio
	animation_player.play(animation)

func shoot() -> void:
	var box: CSGBox3D = CSGBox3D.new()
	get_tree().current_scene.add_child(box)
	
	var shot_point: Vector3 = shot_raycast.get_collision_point()
	var shoot_point: Vector3 = gun.get_node("ShotDirection").global_position
	var exist_timer: SceneTreeTimer = get_tree().create_timer(0.1)
	exist_timer.timeout.connect(box.queue_free)
	
	box.global_position = shoot_point + ((shot_point - shoot_point) / 2)
	box.look_at(shoot_point)
	box.size.z = (shot_point - shoot_point).length() + 1
	box.size.x = 0.07
	box.size.y = 0.07

	animation_player.play(shoot_animation)
	current_bullets_count -= 1
	if current_bullets_count <= 0:
		state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if !(is_next_state_valid(next_state)):
		return true
	state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)
	return false
