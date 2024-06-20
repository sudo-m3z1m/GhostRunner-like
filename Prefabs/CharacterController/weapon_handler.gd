class_name WeaponHandler extends Node

@onready var weapon_pivot: Marker3D = %WeaponPivot
@onready var weapons: Array[Node] = weapon_pivot.get_children()

func add_new_weapon(new_weapon: Weapon) -> void:
	pass
