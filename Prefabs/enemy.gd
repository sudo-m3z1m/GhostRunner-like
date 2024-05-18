extends CharacterBody3D

class_name Enemy

@export var speed: float
@export var gravity: float
@export_node_path("MeshInstance3D") var mesh: NodePath

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $HealthComponent

var direction: Vector3

func _physics_process(delta) -> void:
	velocity.y -= gravity
	move_and_slide()
