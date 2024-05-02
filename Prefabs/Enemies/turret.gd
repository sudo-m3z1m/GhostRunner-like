extends Enemy

@export var cooldown: float
@export var projectile_packed: PackedScene
@export var target_max_speed: float

@onready var weapon_pivot: Node3D = $WeaponPivot
@onready var weapon: MeshInstance3D = $WeaponPivot/MeshInstance3D
@onready var shot_timer: Timer = $ShotTimer
@onready var target: Player = get_tree().current_scene.get_node("Player")

#TODO Need to rewrite enemy class.

func _ready() -> void:
	shot_timer.timeout.connect(shoot)
	shot_timer.start(cooldown)

func _physics_process(delta: float) -> void:
	super(delta)
	rotate_weapon()

func rotate_weapon() -> void:
	weapon_pivot.look_at(target.global_position)

func shoot() -> void:
	var projectile: Projectile = projectile_packed.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = weapon.global_position
	projectile.shoot(find_target_position(projectile))

func find_target_position(projectile: Projectile) -> Vector3:
	var target_direction: Vector3 = target.velocity.normalized()
	var projectile_speed: float = projectile.speed
	var sphere_radius: float
	var max_sphere_radius: float = 100000

	var virtual_target_position = target.global_position
	var len_to_virtual_target: float
	
	while sphere_radius < max_sphere_radius:
		len_to_virtual_target = (global_position - virtual_target_position).length()
		if sphere_radius >= len_to_virtual_target:
			return virtual_target_position
		sphere_radius += projectile_speed
		virtual_target_position += target_direction * target_max_speed
		prints("Projectile radius:", sphere_radius, "Length to target:", len_to_virtual_target)

	return target.global_position
