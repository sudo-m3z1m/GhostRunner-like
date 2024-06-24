extends Weapon

@export var projectile_packed: PackedScene
@export var max_ammo: int

@onready var weapon_raycast: RayCast3D = $Model/WeaponRaycast
@onready var shot_marker: Marker3D = $Model/ShotMarker

var current_ammo: int
