extends CharacterBody3D

class_name Enemy

@export var speed: float
@export var gravity: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta) -> void:
	velocity.y -= gravity
	
	move_and_slide()

func take_damage(direction: Vector3) -> void: #TODO
	var knockback_timer: SceneTreeTimer = get_tree().create_timer(0.5)
	knockback_timer.timeout.connect(reset_velocity)
	
	direction.y = 0
	
	velocity = direction * speed

func reset_velocity() -> void:
	velocity = Vector3.ZERO
