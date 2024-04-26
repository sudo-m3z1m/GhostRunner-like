extends CharacterBody3D

class_name Enemy

@export var speed: float
@export var gravity: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $HealthComponent

var direction: Vector3

func _physics_process(delta) -> void:
	velocity.y -= gravity
	move_and_slide()
