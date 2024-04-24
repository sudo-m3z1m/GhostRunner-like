extends State

class_name TimeState

@export_range(1, 5) var max_bullets_count: int

var current_bullets_count: int
var default_time_scale: float = Engine.time_scale
var gun: Node3D

func enter_state(target: Player) -> void:
	super(target)
	change_time()

func change_time() -> void:
	pass

func shoot() -> void:
	pass
