extends HealthComponent

@export var knockback_time: float
@export var knockback_strength: float
@export var corpse_packed: PackedScene
@export_range(0, 1) var max_y_direction: float

func apply_damage(damage: int, knockback_direction: Vector3 = Vector3.ZERO) -> void:
	super(damage, knockback_direction)
	apply_knockback(knockback_direction)

func die(knockback_direction: Vector3 = Vector3.ZERO) -> void:
	var corpse: RigidBody3D = create_corpse()
	corpse.global_position = global_position
	corpse.apply_central_impulse((knockback_direction) * knockback_strength)

	target.queue_free()

func apply_knockback(direction: Vector3) -> void:
	var knockback_timer: SceneTreeTimer = get_tree().create_timer(knockback_time)
	knockback_timer.timeout.connect(reset_knockback)

	target.velocity = direction * knockback_strength

func reset_knockback() -> void:
	target.velocity = Vector3.ZERO #I know, need to integrate this to state machine but not now

func create_corpse() -> RigidBody3D:
	var corpse: RigidBody3D = corpse_packed.instantiate()
	var target_mesh: MeshInstance3D = target.get_node(target.mesh)
	var corpse_collision_shape: CollisionShape3D
	var corpse_mesh: MeshInstance3D

	get_tree().current_scene.add_child(corpse)
	corpse_mesh = corpse.get_node("MeshInstance")
	corpse_collision_shape = corpse.get_node("CollisionShape")

	corpse_mesh.mesh = target_mesh.mesh
	corpse_collision_shape.shape = target_mesh.mesh.create_convex_shape(true, true)

	return corpse
