class_name UpgradeWall
extends Area2D

@export var upgrade: UpgradeData
@export var size: Enums.UpgradeWallSize = Enums.UpgradeWallSize.HALF

func _ready() -> void:
	if upgrade:
		$Label.text = upgrade.description()
		$Polygon2D.color.r = upgrade.color.r
		$Polygon2D.color.g = upgrade.color.g
		$Polygon2D.color.b = upgrade.color.b
	else:
		$Label.text = "Empty"

func _process(delta: float) -> void:
	position.y += Globals.game_speed * delta
	# Despawn if we're outside the game space.
	if position.y > 1280.0 + 100.0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if upgrade:
		upgrade.apply(area.get_parent() as Player)
	queue_free()
