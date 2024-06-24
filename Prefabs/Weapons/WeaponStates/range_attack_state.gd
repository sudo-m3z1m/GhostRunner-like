extends WeaponState

var projectile_packed: PackedScene
var weapon_raycast: RayCast3D
var shot_position: Vector3

func enter_state(target: Weapon, state_machine: WeaponStateMachine) -> void:
	super(target, state_machine)
	
	projectile_packed = target.projectile_packed
	weapon_raycast = target.weapon_raycast
	shot_position = target.shot_marker.global_position
	
	target_animation_player.animation_finished.connect(end_attack)
	shot()

func shot() -> void:
	var new_projectile: Projectile = projectile_packed.instantiate()
	target.get_tree().current_scene.add_child(new_projectile)
	new_projectile.global_position = shot_position
	new_projectile.shoot(weapon_raycast.get_collision_point())

func update_state(delta: float) -> void:
	pass

func exit_state() -> void:
	pass

func end_attack(animation_name: StringName) -> void:
	var new_state: WeaponState = target.states_array[target.StateIndices.READY].new()
	state_machine.change_state(new_state)
