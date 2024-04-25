extends TimeState

@export_range(1, 5) var slow_time_ratio: float
@export var shoot_animation: String
@export var projectile_packed: PackedScene

var gun: Node3D
var shot_raycast: RayCast3D

func enter_state(target: Player) -> void:
	super(target)
	current_bullets_count = max_bullets_count
	gun = target.camera.get_node("shotgun_placeholder")
	shot_raycast = target.camera.get_node("ShotRaycast")

func change_time() -> void:
	Engine.time_scale = default_time_scale / slow_time_ratio
	animation_player.play(animation)

func shoot() -> void:
	var projectile: Projectile = projectile_packed.instantiate()
	var shot_position: Vector3 = gun.get_node("ShotDirection").global_position
	get_tree().current_scene.add_child(projectile)
	projectile.shoot(shot_position, shot_raycast.get_collision_point())
	
	animation_player.play(shoot_animation)
	current_bullets_count -= 1
	if current_bullets_count <= 0:
		state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if !(is_next_state_valid(next_state)):
		return true
	state_machine.change_time_state(StateMachine.STATES.DEFAULT_TIME)
	return false
