extends Node

class_name TimeController

@export_range(1, 5) var slow_time: float
@export_range(1, 5) var default_ammo_count: float
@export var get_gun_animation: String
@export var shot_animation: String
@export var projectile_packed: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var default_time_scale: float = Engine.time_scale
var ammo_count: float

func enter_state() -> void:
	if Engine.time_scale < default_time_scale:
		exit_state()
		return
	ammo_count = default_ammo_count
	animation_player.play(get_gun_animation)
	Engine.time_scale /= slow_time

func shot() -> void:
	if ammo_count == 0:
		return
	var projectile: Projectile = projectile_packed.instantiate()
	var gun: Node3D = get_parent().get_node("CameraPivot/Camera3D/shotgun_placeholder")
	get_tree().current_scene.add_child(projectile)
	projectile.shoot(gun.global_position, gun.get_node("ShotDirection").global_position)
	
	ammo_count -= 1
	animation_player.play(shot_animation)

func exit_state() -> void:
	animation_player.play_backwards(get_gun_animation)
	Engine.time_scale *= slow_time
