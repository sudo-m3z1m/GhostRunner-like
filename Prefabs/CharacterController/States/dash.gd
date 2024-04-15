extends State

@onready var cooldown_timer: Timer = $DashCooldownTimer

@export var dash_speed: float
@export var dash_time: float
@export var delta_dash_fov: float
@export var cooldown: float

const MAX_VERTICLE_DASH_LENGTH = 40

func enter_state(target: Player) -> void:
	super(target)
	if !cooldown_timer.is_stopped():
		finish_dash()
		return
	
	var dash_timer: SceneTreeTimer = get_tree().create_timer(dash_time)
	dash_timer.timeout.connect(finish_dash)
	
	animate_transition(true)
	start_dash()

func update_state(delta: float) -> void:
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false

func start_dash() -> void:
	var direction: Vector3
	direction = target.camera.global_position.direction_to(target.dash_marker.global_position)

	target.velocity = direction * dash_speed

	target.velocity.y = clamp(target.velocity.y, -target.gravity, MAX_VERTICLE_DASH_LENGTH)

	cooldown_timer.start(cooldown)

func finish_dash() -> void:
	animate_transition(false)
	state_machine.change_state(StateMachine.STATES.FALLING)

func animate_transition(animation_in: bool):
	var transition_fov: float = target.default_fov
	var tween: Tween = create_tween()
	
	if animation_in:
		transition_fov += delta_dash_fov
	
	tween.tween_property(target.camera, "fov", transition_fov, dash_time)
