extends Panel

@onready var continue_button: Button = $MarginContainer/VBoxContainer/ContinueButton
@onready var settings_button: Button = $MarginContainer/VBoxContainer/SettingsButton
@onready var exit_button: Button = $MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	continue_button.pressed.connect(HUD.pause_clicked)
	settings_button.pressed.connect(HUD.settings_clicked)
	exit_button.pressed.connect(HUD.exit_clicked)
