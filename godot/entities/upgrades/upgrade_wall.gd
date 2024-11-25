class_name UpgradeWall
extends Node2D

@export var left_upgrade: UpgradeData
@export var right_upgrade: UpgradeData

func _ready() -> void:
	$LeftSegment.upgrade = left_upgrade
	$RightSegment.upgrade = right_upgrade

func _process(delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
		return

	position.y += Globals.game_speed * delta

func _on_segment_picked_up(segment: UpgradeWallSegment) -> void:
	if $LeftSegment == segment:
		$RightSegment.expire()
	else:
		$LeftSegment.expire()
