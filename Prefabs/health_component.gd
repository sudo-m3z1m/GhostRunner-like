extends Node3D

class_name HealthComponent
#TODO This is will be centralized damage system.
@export var max_health_points: int
@export var knockback_strength: float

@onready var target: Node3D = get_parent()

var health_points_count: int

func apply_damage(direction: Vector3) -> void:
	if health_points_count <= 1: 
		die()
		return
	health_points_count -= 1
	target.velocity = direction * knockback_strength

func heal_up() -> void:
	health_points_count = max_health_points

func die() -> void:
	pass
