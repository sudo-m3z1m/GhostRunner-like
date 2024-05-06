extends HealthComponent

@export var knockback_time: float
@export var knockback_strength: float
@export var death_body_packed: PackedScene

var knockback_direction: Vector3

func apply_damage(damage: int, damage_dealer: Node3D) -> void:
	knockback_direction = damage_dealer.velocity.normalized()
	super(damage, damage_dealer)
	apply_knockback(knockback_direction)

func die() -> void:
	var death_body: RigidBody3D = death_body_packed.instantiate() #TODO Need to generate body because i will can slide enemies
	get_tree().current_scene.add_child(death_body)
	death_body.global_position = target.global_position
	death_body.apply_central_impulse(knockback_direction * 70) #TODO And need to remade this for more dynamicly impulse adding

	target.queue_free()

func apply_knockback(direction: Vector3) -> void:
	var knockback_timer: SceneTreeTimer = get_tree().create_timer(knockback_time)
	knockback_timer.timeout.connect(reset_knockback)
	
	target.velocity = direction * knockback_strength

func reset_knockback() -> void:
	target.velocity = Vector3.ZERO #I know, need to integrate this to state machine but not now
