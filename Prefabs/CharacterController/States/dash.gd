extends State

@export var dash_speed: float
@export var dash_time: float
@export var delta_dash_fov: float

var dash_timer: SceneTreeTimer

func enter_state(target: Player) -> void:
	super(target)
	
	dash_timer = get_tree().create_timer(dash_time)
	dash_timer.timeout.connect(finish_dash)
	
	animate_transition(true)
	start_dash()

func update_state(delta: float) -> void:
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		animate_transition(false)
		return true
	return false

func start_dash() -> void:
	var direction: Vector3 = Vector3.FORWARD
	direction = direction.rotated(Vector3.UP, target.camera.rotation.y)
	direction = direction.rotated(Vector3.RIGHT, target.camera.rotation.x)
	
	target.velocity = direction * dash_speed

func finish_dash() -> void:
	state_machine.change_state(StateMachine.STATES.IDLE)

func animate_transition(animation_in: bool):
	var transition_fov: float = target.default_fov
	var tween: Tween = create_tween()
	
	if animation_in:
		transition_fov += delta_dash_fov
	
	tween.tween_property(target.camera, "fov", transition_fov, 0.01)
