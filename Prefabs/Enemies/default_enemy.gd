extends Enemy

@export var cooldown: float
@export var projectile_packed: PackedScene

@onready var weapon_pivot: Node3D = $WeaponPivot
@onready var weapon: MeshInstance3D = $WeaponPivot/MeshInstance3D #TODO
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var target: Player = get_tree().current_scene.get_node("Player")

func _ready() -> void:
	cooldown_timer.timeout.connect(shoot)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()

func _physics_process(delta: float) -> void:
	super(delta)
	rotate_weapon()

func rotate_weapon() -> void:
	weapon_pivot.look_at(target.global_position)

func shoot() -> void:
	var projectile: Projectile = projectile_packed.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.shoot(weapon.global_position, target.global_position)
