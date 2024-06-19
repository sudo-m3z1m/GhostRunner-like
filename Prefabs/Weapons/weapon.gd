class_name Weapon
extends RigidBody3D

@export var throw_damage: float
@export var model_animation_player: AnimationPlayer

@onready var Model: Node3D = $Model
