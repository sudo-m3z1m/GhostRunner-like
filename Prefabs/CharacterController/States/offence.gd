extends AttackState

@export var dash_attack_speed: float
@export var attack_damage: int

var attack_area: Area3D

const MAX_VERTICLE_VELOCITY: float = 30

func enter_state(target: Player, attack_state: State, animation_player: AnimationPlayer) -> void:
	super(target, attack_state, animation_player)

	attack_area = attack_state.attack_area
	animation_player.play(animation)
	start_attack()

func update_state(delta: float) -> void:
	is_area_trigerred() #TODO need to make weapon_component for this stuff
	is_animation_ended()
	
	target.move_and_slide()

func start_attack() -> void:
	var direction: Vector3 = Vector3.FORWARD
	direction *= target.camera.quaternion.inverse()
	target.velocity += direction * dash_attack_speed
	target.velocity.y = clamp(target.velocity.y, -MAX_VERTICLE_VELOCITY, MAX_VERTICLE_VELOCITY)

func is_animation_ended() -> void:
	if animation_player.is_playing():
		return
	attack_state.change_attack_state()

func is_area_trigerred() -> void:
	var knockback_direction: Vector3 = target.velocity.normalized()
	knockback_direction.y = randf_range(0.1, 0.5)
	for entity in attack_area.get_overlapping_bodies():
		if entity is Enemy:
			entity.health_component.apply_damage(attack_damage, knockback_direction)
			attack_state.change_attack_state()
		if entity is Projectile:
			entity.shoot(target.gun.shot_raycast.get_collision_point())
