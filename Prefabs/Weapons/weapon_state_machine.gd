class_name WeaponStateMachine extends Node

@onready var target: Weapon = get_parent()

var current_state: WeaponState = WeaponState.new()

func _process(delta: float) -> void:
	current_state.update_state(delta)

func change_state(new_state: WeaponState) -> void:
	current_state.exit_state()
	current_state = new_state
	current_state.enter_state(target, self)
