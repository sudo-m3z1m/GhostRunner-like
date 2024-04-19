extends AttackState

@export var dash_attack_speed: float

var attack_area: Area3D

const MAX_VERTICLE_VELOCITY: float = 20

func enter_state(target: Player, attack_state: State, animation_player: AnimationPlayer) -> void:
	super(target, attack_state, animation_player)

	attack_area = attack_state.attack_area
	animation_player.play(animation)
	start_attack()

func update_state(delta: float) -> void:
	check_preys()
	is_animation_ended()
	
	target.move_and_slide()

func exit_state() -> void:
	pass

func start_attack() -> void:
	var direction: Vector3
	direction = target.camera.global_position.direction_to(target.dash_marker.global_position)
	target.velocity += direction * dash_attack_speed
	target.velocity.y = clamp(target.velocity.y, -MAX_VERTICLE_VELOCITY, MAX_VERTICLE_VELOCITY)

func check_preys() -> void:
	for body in attack_area.get_overlapping_bodies():
		if !(body is Enemy):
			continue
		body.take_damage(Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y))

func is_animation_ended() -> void:
	if animation_player.is_playing():
		return
	attack_state.change_attack_state()
