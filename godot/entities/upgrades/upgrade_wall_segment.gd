class_name UpgradeWallSegment
extends Area2D

signal picked_up(segment: UpgradeWallSegment)

@export var upgrade: UpgradeData:
	set(value):
		upgrade = value
		_update_visuals()

@export var size: Enums.UpgradeWallSize = Enums.UpgradeWallSize.HALF

var _expired := false

func _ready() -> void:
	_update_visuals()

func _on_area_entered(area: Area2D) -> void:
	if !is_queued_for_deletion() and !_expired:
		pick_up(area.get_parent() as Player)

func _update_visuals() -> void:
	if upgrade:
		$Label.text = upgrade.description()
		$Polygon2D.color.r = upgrade.color.r
		$Polygon2D.color.g = upgrade.color.g
		$Polygon2D.color.b = upgrade.color.b
	else:
		$Label.text = "Empty"

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func pick_up(player: Player) -> void:
	if upgrade:
		upgrade.apply(player)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("picked_up")
	picked_up.emit(self)

func expire() -> void:
	_expired = true
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("expired")
