extends HealthComponent

@export var knockback_time: float
@export var knockback_strength: float

func apply_damage(damage: int, damage_dealer: Node3D) -> void:
	super(damage, damage_dealer)
	apply_knockback(damage_dealer.velocity.normalized())

func die() -> void:
	queue_free()

func apply_knockback(direction: Vector3) -> void:
	var knockback_timer: SceneTreeTimer = get_tree().create_timer(knockback_time)
	knockback_timer.timeout.connect(reset_knockback)
	
	target.velocity = direction * knockback_strength

func reset_knockback() -> void:
	target.velocity = Vector3.ZERO #I know, need to integrate this to state machine but not now
