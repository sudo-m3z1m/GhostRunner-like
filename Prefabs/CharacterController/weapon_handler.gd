class_name WeaponHandler extends Node

@onready var target: Player = get_parent()
@onready var weapon_pivot: Marker3D = %WeaponPivot
@onready var interactive_area: Area3D = %InteractiveArea
@onready var weapons: Array[Node] = weapon_pivot.get_children()
@onready var current_weapon: Weapon = null


func _ready() -> void:
	interactive_area.body_entered.connect(check_new_bodies)
	weapons.resize(2)

func check_new_bodies(new_body: Node3D) -> void:
	if !(new_body is Weapon):
		return
	add_new_weapon(new_body)

func add_new_weapon(new_weapon: Weapon) -> void:
	if current_weapon:
		current_weapon.throw_self(Vector3.FORWARD)
	weapons[1] = new_weapon
	current_weapon = new_weapon
	current_weapon.global_position = weapon_pivot.global_position
	current_weapon.reparent(weapon_pivot)
	current_weapon.rotation = Vector3.ZERO
	current_weapon.get_weapon()
