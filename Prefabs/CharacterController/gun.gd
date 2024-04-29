extends Node3D

class_name Gun

@export_range(1, 5) var max_ammo_count: int
@export var shoot_animation: String
@export var projectile_packed: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shot_position: Marker3D = $ShotPosition
@onready var shot_raycast: RayCast3D = $ShotRaycast
@onready var current_ammo_count: int = max_ammo_count
@onready var states: Dictionary = {
	GUN_STATES.GET_UP: $GetUpState,
	GUN_STATES.GET_DOWN: $GetDownState
}

enum GUN_STATES {
	GET_UP,
	GET_DOWN
}

var current_state: GunState = GunState.new()
var gun_owner: Player

func change_state(next_state: GUN_STATES) -> void:
	if !current_state.state_exit(next_state):
		return
	current_state = states[next_state]
	current_state.enter_state(gun_owner)

func shoot() -> void:
	if current_state != states[GUN_STATES.GET_UP] or current_ammo_count == 0:
		return
	var projectile: Projectile = projectile_packed.instantiate()
	animation_player.play(shoot_animation)
	
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = shot_position.global_position
	projectile.shoot(shot_raycast.get_collision_point())
	
	current_ammo_count -= 1
