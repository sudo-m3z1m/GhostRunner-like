extends State

class_name TimeState

var default_time_scale: float = Engine.time_scale

func enter_state(target: Player) -> void:
	super(target)
	change_time()

func change_time() -> void:
	pass
