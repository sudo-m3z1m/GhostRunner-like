class_name Weapon
extends RigidBody3D

@export var throw_damage: float
@export var model_animation_player: AnimationPlayer
@export var states_array: Array[GDScript]

@onready var Model: Node3D = $Model

enum StateIndeces {
	READY,
	ATTACK,
	THROW
}
