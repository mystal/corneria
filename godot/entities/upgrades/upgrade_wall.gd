class_name UpgradeWall
extends Area2D

@export var size: Enums.UpgradeWallSize = Enums.UpgradeWallSize.HALF

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += Globals.game_speed * delta
	# Despawn if we're outside the game space.
	if position.y > 1280.0 + 100.0:
		queue_free()
