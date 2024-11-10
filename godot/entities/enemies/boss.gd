class_name Boss
extends "res://entities/enemies/enemy.gd"

func _physics_process(delta: float) -> void:
	super(delta)

func died() -> void:
	Globals.player_won()
	super()
