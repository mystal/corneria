class_name Projectile
extends Area2D

@export_group("Movement")
@export_range(0.0, 2000.0, 5.0, "or_greater") var speed: float = 600.0

var instigator: Node = null:
	set(value):
		instigator = value
		if value.faction == Enums.Faction.PLAYER:
			$Polygon2D.color = Color.WHITE
		else:
			$Polygon2D.color = Color.RED

var faction: Enums.Faction:
	get:
		if instigator:
			return instigator.faction
		return Enums.Faction.PLAYER

var dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += dir * speed * delta
