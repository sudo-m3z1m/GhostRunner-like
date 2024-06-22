class_name Weapon
extends RigidBody3D

@export var throw_damage: float
@export var model_animation_player: AnimationPlayer
@export var states_array: Array[GDScript]
@export var first_state: StateIndices

@onready var Model: Node3D = $Model
@onready var state_machine: WeaponStateMachine = $StateMachine

enum StateIndices {
	READY,
	ATTACK,
	THROW
}

func _ready() -> void:
	var new_state: WeaponState = states_array[first_state].new()
	state_machine.change_state(new_state)

func throw_self(direction: Vector3) -> void:
	pass

func attack() -> void:
	var new_state: WeaponState = states_array[StateIndices.ATTACK].new()
	state_machine.change_state(new_state)

func get_weapon() -> void:
	var new_state: WeaponState = states_array[StateIndices.READY].new()
	state_machine.change_state(new_state)
