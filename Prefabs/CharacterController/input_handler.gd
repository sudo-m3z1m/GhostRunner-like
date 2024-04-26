extends Node

class_name InputHandler

@export var sensintivity: float

@onready var target: Player = get_parent()
@onready var state_machine: StateMachine = get_parent().get_node("StateMachine")

var actions_array: Array[String] = [
	"Space",
	"Shift",
	"Escape",
	"Attack",
	"GetWeapon",
	"AlternativeAttack"
]

var move_actions_array: Array[String] = [
	"Back",
	"Forward",
	"Left",
	"Right"
]

func _process(delta: float) -> void:
	add_direction()

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		target.camera.rotation.y -= event.relative.x * sensintivity
		target.camera.rotation.x -= event.relative.y * sensintivity
		target.raycasts_pivot.rotation.y = target.camera.rotation.y

	for action in actions_array:
		if event.is_action_pressed(action):
			get_action(action)

func add_direction() -> void:
	state_machine.direction = Vector3.ZERO
	if Input.is_action_pressed("Back"):
		state_machine.direction.z += 1
	if Input.is_action_pressed("Forward"):
		state_machine.direction.z -= 1
	if Input.is_action_pressed("Left"):
		state_machine.direction.x -= 1
	if Input.is_action_pressed("Right"):
		state_machine.direction.x += 1
	if !state_machine.direction:
		state_machine.change_state(StateMachine.STATES.IDLE)
		return
	state_machine.change_state(StateMachine.STATES.MOVING)
	state_machine.direction = state_machine.direction.normalized()

func get_action(action: String) -> void:
	match action:
		"Space":
			state_machine.change_state(StateMachine.STATES.JUMP)
		"Shift":
			state_machine.change_state(StateMachine.STATES.DASH)
		"Escape":
			HUD.pause_clicked()
		"Attack":
			state_machine.change_state(StateMachine.STATES.ATTACK)
		"GetWeapon":
			target.gun.change_state(Gun.GUN_STATES.GET_UP)
		"AlternativeAttack":
			target.gun.shoot()
