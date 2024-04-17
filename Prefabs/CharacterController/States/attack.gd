extends State
#TODO maybe attack state don't needed at attack area and
#I need to think about that. Need to make 2 states in attack state.
#One with attack and damage deal and second with placing kataba back.
#Need to think about retrying transitions in attack state
@onready var cooldown_timer: Timer = $CooldownTimer

@export var dash_attack_speed: float
@export var cooldown: float

var attack_area: Area3D

func enter_state(target: Player) -> void:
	super(target)
	if !cooldown_timer.is_stopped():
		state_machine.change_state(StateMachine.STATES.FALLING)
		return
	
	attack_area = target.attack_area
	cooldown_timer.start(cooldown)
	animation_player.play(animation)
	start_attack()

func update_state(delta: float) -> void:
	if !animation_player.is_playing():
		state_machine.change_state(StateMachine.STATES.FALLING)
	give_damage()
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false

func start_attack() -> void:
	var direction: Vector3
	direction = target.camera.global_position.direction_to(target.dash_marker.global_position)
	target.velocity += direction * dash_attack_speed

	cooldown_timer.start(cooldown)

func give_damage() -> void:
	for body in attack_area.get_overlapping_bodies():
		if !(body is Enemy):
			continue
		body.take_damage(Vector3.FORWARD.rotated(Vector3.UP, target.camera.rotation.y))
