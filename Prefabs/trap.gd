extends RigidBody3D

class_name Trap

@onready var hurt_box: Area3D = $HurtBox

var velocity: Vector3

func _ready() -> void:
	hurt_box.body_entered.connect(check_collisions)

func _physics_process(delta) -> void:
	velocity = linear_velocity

func check_collisions(body: Node3D) -> void:
	var body_health_component: HealthComponent = body.get_node_or_null("HealthComponent")
	if !body_health_component:
		return
	body_health_component.apply_damage(body_health_component.health_points_count, self)
