extends CanvasLayer

class_name Hud

@onready var game_over_hud: Panel = $MarginContainer/GameOverHud
@onready var hud_dict: Dictionary = {
	"GameOver" : game_over_hud
}

func set_hud_visible(hud: String, is_visible: bool) -> void:
	hud_dict[hud].visible = is_visible
