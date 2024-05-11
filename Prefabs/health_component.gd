extends Node3D

class_name HealthComponent

@export var max_health_points: int

@onready var target: Node3D = get_parent()
@onready var health_points_count: int = max_health_points

func apply_damage(damage: int, knockback_direction: Vector3 = Vector3.ZERO) -> void:
	health_points_count -= damage
	if health_points_count <= 0:
		die()

func heal_up() -> void:
	health_points_count = max_health_points

func die() -> void:
	pass

func apply_knockback(direction: Vector3) -> void:
	pass
