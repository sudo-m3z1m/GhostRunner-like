extends CharacterBody3D

class_name Player

@export var default_fov: float
@export var camera_max_degrees: float
@export var gravity: float
@export var max_angle: float

@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var camera_pivot: Node3D = $CameraPivot
@onready var dash_marker: Marker3D = $CameraPivot/Camera3D/Marker3D
@onready var input_handler: InputHandler = $InputHandler
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = default_fov

func _physics_process(delta: float) -> void:
	velocity.y -= gravity
	
	camera.rotation.x = clamp(camera.rotation.x, -deg_to_rad(camera_max_degrees), deg_to_rad(camera_max_degrees))
