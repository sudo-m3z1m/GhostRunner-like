extends State

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var attack_state: AttackState = $Offence
@onready var recoil_state: AttackState = $Recovery

@export var cooldown: float

var current_state: AttackState
var attack_area: Area3D

func change_attack_state() -> void: #TODO need to rewrite this shit to more dynamicly state changing
	current_state.exit_state()
	current_state = recoil_state
	current_state.enter_state(target, self, animation_player)

func enter_state(target: Player) -> void:
	super(target)
	if !cooldown_timer.is_stopped():
		state_machine.change_state(StateMachine.STATES.FALLING)
		return

	attack_area = target.attack_area
	cooldown_timer.start(cooldown)
	current_state = attack_state
	
	attack_state.enter_state(target, self, animation_player)

func update_state(delta: float) -> void:
	current_state.update_state(delta)

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false
