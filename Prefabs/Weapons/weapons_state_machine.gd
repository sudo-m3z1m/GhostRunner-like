extends Node
class_name WeaponStateMachine

@onready var target: Weapon = get_parent()

var current_state: WeaponState

func _process(delta: float) -> void:
	pass

func change_state(new_state: WeaponState) -> void:
	pass
