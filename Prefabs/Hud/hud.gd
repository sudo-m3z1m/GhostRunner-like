extends CanvasLayer

class_name Hud

@onready var game_over_hud: Panel = $MarginContainer/GameOverHud
@onready var settings_menu: Panel = $MarginContainer/SettingsMenuPanel
@onready var pause_menu: Panel = $MarginContainer/PauseMenu
@onready var hp_bar: TextureProgressBar = $MarginContainer/HpBar
@onready var hud_dict: Dictionary = {
	"GameOver" : game_over_hud,
	"Pause" : pause_menu,
	"Settings" : settings_menu
}

func set_hud_visible(hud: String, is_visible: bool) -> void:
	hud_dict[hud].visible = is_visible

func pause_clicked() -> void:
	if game_over_hud.visible:
		return
	get_tree().paused = !pause_menu.visible
	set_hud_visible("Pause", !pause_menu.visible)
	Input.set_mouse_mode(2 * int(!pause_menu.visible))

func settings_clicked() -> void:
	set_hud_visible("Settings", !hud_dict["Settings"].visible)

func exit_clicked() -> void:
	get_tree().quit(0)

func set_hp_bar_value(new_hp_bar_value: int) -> void:
	hp_bar.value = new_hp_bar_value
