extends State

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_handler: WeaponHandler = owner.get_node("WeaponHandler")

@export var cooldown: float

func enter_state(target: Player) -> void:
	super(target)
	if !cooldown_timer.is_stopped():
		state_machine.change_state(StateMachine.STATES.FALLING)
		return

	cooldown_timer.start(cooldown)
	state_machine.change_state(StateMachine.STATES.FALLING)

func update_state(delta: float) -> void:
	target.move_and_slide()

func exit_state(next_state: StateMachine.STATES) -> bool:
	if is_next_state_valid(next_state):
		return true
	return false
