class_name ModifyMoveSpeed
extends UpgradeData

@export var amount_to_add: float

func apply(player: Player) -> void:
	if !player:
		return
	player.player_movement.lerp_speed += amount_to_add

func description() -> String:
	if amount_to_add > 0:
		return "%+.1f Move Speed" % amount_to_add
	return "{}"
