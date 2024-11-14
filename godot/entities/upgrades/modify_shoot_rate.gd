class_name ModifyShootRate
extends UpgradeData

@export var amount_to_add: float

func apply(player: Player) -> void:
	if !player:
		return
	player.projectile_shooter.fire_rate += amount_to_add

func description() -> String:
	if amount_to_add > 0:
		return "%+.1f Fire Rate" % amount_to_add
	return "{}"
