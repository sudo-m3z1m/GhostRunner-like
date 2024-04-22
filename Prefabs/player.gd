extends CharacterBody3D

class_name Player

@export var default_fov: float
@export var camera_max_degrees: float
@export var gravity: float
@export var max_angle: float
@export var max_jump_count: int

@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var camera_pivot: Node3D = $CameraPivot
@onready var dash_marker: Marker3D = $CameraPivot/Camera3D/Marker3D
@onready var input_handler: InputHandler = $InputHandler
@onready var state_machine: StateMachine = $StateMachine
@onready var raycasts: Array[Node] = $Raycasts.get_children()
@onready var raycasts_pivot: Node3D = $Raycasts
@onready var attack_area: Area3D = $CameraPivot/Camera3D/AttackArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var jump_count: int = max_jump_count

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = default_fov

func _physics_process(delta: float) -> void:
	velocity.y -= gravity / (1 / Engine.time_scale)
	camera.rotation.x = clamp(camera.rotation.x, -deg_to_rad(camera_max_degrees), deg_to_rad(camera_max_degrees))

func is_falling() -> void:
	if !is_on_floor():
		state_machine.change_state(StateMachine.STATES.FALLING)

func kill() -> void:
	get_tree().paused = true
	
	HUD.set_hud_visible("GameOver", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
