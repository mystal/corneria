class_name ModifyMaxHealth
extends UpgradeData

@export var amount_to_add: float

func apply(player: Player) -> void:
	if !player:
		return
	player.health.max_health += amount_to_add

func description() -> String:
	if amount_to_add > 0:
		return "%+.1f Max Health" % amount_to_add
	return "{}"
