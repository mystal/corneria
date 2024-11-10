class_name Boss
extends "res://entities/enemies/enemy.gd"

func _physics_process(delta: float) -> void:
	super(delta)

func _exit_tree() -> void:
	Globals.player_wins()
	super()
