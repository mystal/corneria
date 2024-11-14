class_name ModifyShootRate
extends UpgradeData

@export var amount_to_add: float

func apply(player: Player) -> void:
	if !player:
		return

	player.projectile_shooter.fire_rate += amount_to_add
