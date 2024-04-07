extends CharacterBody3D

class_name Player

@export var max_speed: float
@export var default_fov: float
@export var camera_clamp_degrees: float
@export var jump_strength: float
@export var acceleration_weight: float
@export var gravity: float #Need to make this global variable
@export var sensintivity: float
@export var dash_speed: float
@export var max_angle: float

@onready var camera: Camera3D = $Camera3D
#@onready var input_handler: Node = $InputHandler
#@onready var state_machine: Node = $StateMachine

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = default_fov

func _physics_process(delta: float) -> void:
	velocity.x = lerp(velocity.x, get_direction().x * max_speed, acceleration_weight)
	velocity.z = lerp(velocity.z, get_direction().z * max_speed, acceleration_weight)
	
	velocity.y -= gravity
	
	camera.rotation.x = clamp(camera.rotation.x, -deg_to_rad(camera_clamp_degrees), deg_to_rad(camera_clamp_degrees))
	move_and_slide()

func make_dash() -> void:
	var direction: Vector3 = Vector3.FORWARD.rotated(Vector3.UP, camera.rotation.y)
	var tween: Tween = create_tween()
	
	velocity = direction * dash_speed
	await tween.tween_property(camera, "fov", default_fov + 40, 0.1)
	await tween.tween_property(camera, "fov", default_fov, 0.1)

#InputHandler
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera.rotation.y -= event.relative.x * sensintivity
		camera.rotation.x -= event.relative.y * sensintivity
	if event.is_action("Space") and is_on_floor():
		velocity += Vector3.UP * jump_strength
	if event.is_action("Shift"):
		make_dash()

func get_direction() -> Vector3:
	var direction: Vector3
	direction.x = Input.get_axis("Left", "Right")
	direction.z = Input.get_axis("Forward", "Back")
	
	camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, (direction.x * max_angle) + camera.rotation_degrees.z, 0.1)
	camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, (direction.z * max_angle) + camera.rotation_degrees.x, 0.1)
	
	direction = direction.rotated(Vector3.UP, camera.rotation.y)
	
	return direction

#Need to trnsit this code into the states
