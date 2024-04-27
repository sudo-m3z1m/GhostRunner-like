extends Enemy

@export var cooldown: float
@export var projectile_packed: PackedScene

@onready var weapon_pivot: Node3D = $WeaponPivot
@onready var weapon: MeshInstance3D = $WeaponPivot/MeshInstance3D
@onready var shot_timer: Timer = $ShotTimer
@onready var target: Player = get_tree().current_scene.get_node("Player")

#TODO Need to rewrite enemy class and this class too.

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
	projectile.shoot(target.global_position)
