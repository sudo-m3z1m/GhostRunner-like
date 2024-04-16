extends Node3D

class_name Projectile

@export var speed: float

var velocity: Vector3

func _physics_process(delta) -> void:
	global_position += velocity

func shoot(shot_position: Vector3, target_position: Vector3) -> void:
	global_position = shot_position
	look_at(target_position)
	var direction: Vector3 = (target_position - global_position).normalized()
	velocity = direction * speed
