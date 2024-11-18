class_name Boss
extends "res://entities/enemies/enemy.gd"

func _physics_process(delta: float) -> void:
	super(delta)

func _on_health_died() -> void:
	Globals.player_won()
	super()
