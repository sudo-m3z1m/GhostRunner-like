extends AttackState

@export_range(0, 1) var inertia_weight: float

func enter_state(target: Player, attack_state: State, animation_player: AnimationPlayer) -> void:
	super(target, attack_state, animation_player)
	
	animation_player.play(animation)

func update_state(delta: float) -> void:
	#target.velocity.x = lerp(target.velocity.x, 0.0, inertia_weight)
	#target.velocity.z = lerp(target.velocity.z, 0.0, inertia_weight)
	
	target.move_and_slide()
	is_animation_ended()

func exit_state() -> void:
	pass

func is_animation_ended() -> void:
	if animation_player.is_playing():
		return
	attack_state.state_machine.change_state(StateMachine.STATES.FALLING)
