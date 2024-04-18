extends CanvasLayer

@onready var start_button: Button = $MarginContainer/MainMenuPanel/MarginContainer/ButtonsContainer/StartButton
@onready var settings_button: Button = $MarginContainer/MainMenuPanel/MarginContainer/ButtonsContainer/SettingsButton
@onready var exit_button: Button = $MarginContainer/MainMenuPanel/MarginContainer/ButtonsContainer/ExitButton

func _ready() -> void:
	exit_button.pressed.connect(HUD.exit_clicked)
	settings_button.pressed.connect(HUD.settings_clicked)
