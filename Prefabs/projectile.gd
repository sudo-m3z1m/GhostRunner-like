extends CharacterBody3D
class_name Projectile

@export var speed: float
@export var exist_time: float
@export var damage: int

@onready var exist_timer: Timer = $Timer
@onready var hurt_box_area: Area3D = $HurtBoxArea

func _physics_process(delta: float) -> void:
	is_collision_damagable()
	move_and_slide()

func shoot(target_position: Vector3) -> void: #Probably need to redefine
	look_at(target_position)
	var direction: Vector3 = (target_position - global_position).normalized()
	velocity = direction * speed

func is_collision_damagable() -> void:
	if !get_last_slide_collision():
		return
	var collider: Object = get_last_slide_collision().get_collider()
	if collider is Player:
		collider.health_component.apply_damage(damage, self)
	queue_free()
