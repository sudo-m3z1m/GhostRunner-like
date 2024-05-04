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
	var Sb: float = projectile.speed
	var T: Vector3 = target.global_position - global_position
	var Vt: Vector3 = target.velocity
	var _b: float = (T.x * Vt.x + T.y * Vt.y + T.z * Vt.z)
	var _E: float = sqrt((T.x * Vt.x + T.y * Vt.y + T.z * Vt.z) ** 2 + (Sb ** 2 - Vt.x ** 2 - Vt.y ** 2 - Vt.z ** 2)\
	 * (T.x ** 2 + T.y ** 2 + T.z ** 2))
	var _a = (Sb ** 2 - Vt.x ** 2 - Vt.y ** 2 - Vt.z ** 2)
	var t_1: float = (_b + _E) / _a
	var t_2: float = (_b - _E) / _a
	var t: float = 0

	if t_1 >= 0 and t_2 >= 0:
		t = minf(t_1, t_2)
	else:
		t = maxf(t_1, t_2)
	var Vb = T / t + Vt

	return global_position + Vb
