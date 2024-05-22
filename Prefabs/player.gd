extends CharacterBody3D

class_name Player

@export var default_fov: float
@export var camera_max_degrees: float
@export var gravity: float
@export var max_angle: float
@export var max_jump_count: int

@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var weapon_camera: Camera3D = $CameraPivot/SubViewportContainer/SubViewport/WeaponCamera
@onready var camera_pivot: Node3D = $CameraPivot
@onready var input_handler: InputHandler = $InputHandler
@onready var state_machine: StateMachine = $StateMachine
@onready var raycasts: Array[Node] = $Raycasts.get_children()
@onready var raycasts_pivot: Node3D = $Raycasts
@onready var attack_area: Area3D = $CameraPivot/Camera3D/AttackArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $HealthComponent
@onready var gun: Gun = $CameraPivot/Camera3D/Gun

var jump_count: int = max_jump_count
var prev_raycasts_states: Array[bool] = [false, false]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = default_fov
	gun.gun_owner = self
 
func _physics_process(delta: float) -> void:
	velocity.y -= gravity / (1 / Engine.time_scale)
	camera.rotation.x = clamp(camera.rotation.x, -deg_to_rad(camera_max_degrees), deg_to_rad(camera_max_degrees))

func _process(delta) -> void:
	weapon_camera.global_position = camera.global_position
	weapon_camera.rotation = camera.rotation

func is_falling() -> void:
	if !is_on_floor():
		state_machine.change_state(StateMachine.STATES.FALLING)

func check_raycasts_collision() -> void:
	for raycast_index in raycasts.size():
		if raycasts[raycast_index].is_colliding() == prev_raycasts_states[raycast_index] or \
		raycasts[raycast_index].is_colliding() == false:
			continue
		state_machine.change_state(StateMachine.STATES.WALLRUN)

func copy_raycasts_collisions() -> void:
	for raycast_index in raycasts.size():
		prev_raycasts_states[raycast_index] = raycasts[raycast_index].is_colliding()
