extends Node3D
#TODO Need to remake all this class need to think
class_name Projectile

@export var speed: float
@export var exist_time: float

@onready var exist_timer: Timer = $Timer
@onready var hurt_box_area: Area3D = $HurtBoxArea

var velocity: Vector3
