extends Node3D

class_name Projectile

@export var speed: float
@export var exist_time: float

@onready var exist_timer: Timer = $Timer
@onready var hurt_box_area: Area3D = $HurtBoxArea

var velocity: Vector3

func _ready() -> void:
	exist_timer.timeout.connect(queue_free)
	hurt_box_area.body_entered.connect(hurt_box_entered)

func _physics_process(delta) -> void:
	global_position += velocity

func shoot(shot_position: Vector3, target_position: Vector3) -> void:
	global_position = shot_position
	look_at(target_position)
	var direction: Vector3 = (target_position - global_position).normalized()
	velocity = direction * speed
	
	exist_timer.start(exist_time)

func hurt_box_entered(body: Node3D) -> void:
	if (body is Player):
		body.kill() #TODO Need to make one centralized system of killing or damage dealing
		#maybe this is just useless I need to think about it.

	queue_free()
