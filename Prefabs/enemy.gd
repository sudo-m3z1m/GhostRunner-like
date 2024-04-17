extends CharacterBody3D

class_name Enemy

@export var speed: float
@export var gravity: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var direction: Vector3

func _physics_process(delta) -> void:
	velocity.y -= gravity
	
	velocity.x = lerp(velocity.x, direction.x * speed, 0.05)
	velocity.z = lerp(velocity.z, direction.z * speed, 0.05)

	move_and_slide()

func take_damage(dir: Vector3) -> void: #TODO I wrote same shit in projectile class.
	var knockback_timer: SceneTreeTimer = get_tree().create_timer(0.1)
	knockback_timer.timeout.connect(reset_velocity)
	
	dir.y = 0
	
	self.direction = dir

func reset_velocity() -> void:
	direction = Vector3.ZERO
