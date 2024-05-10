extends HealthComponent

func apply_damage(damage: int, damage_dealer: Node3D) -> void:
	super(damage, damage_dealer)
	HUD.set_hp_bar_value(health_points_count)

func die() -> void:
	get_tree().paused = true
	
	HUD.set_hud_visible("GameOver", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
