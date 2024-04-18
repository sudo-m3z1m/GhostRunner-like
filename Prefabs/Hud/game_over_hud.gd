extends Panel

@onready var retry_button: Button = $VBoxContainer/HBoxContainer/RetryButton
@onready var exit_button: Button = $VBoxContainer/HBoxContainer/ExitButton

var hud: String = "GameOver"

func _ready() -> void:
	retry_button.pressed.connect(retry_clicked)
	exit_button.pressed.connect(HUD.exit_clicked)

func retry_clicked() -> void: #TODO Need make one centralized system of HUD
	get_tree().paused = false
	HUD.set_hud_visible(hud, false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
