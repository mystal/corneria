class_name Projectile
extends Area2D

@export_group("Movement")
@export_range(0.0, 2000.0, 5.0, "or_greater") var speed: float = 600.0
@export var max_range: float = 600.0

@export_group("Colors")
@export var friendly_color: Color = Color.WHITE
@export var hostile_color: Color = Color.ORANGE_RED

@onready var lifetime: float = max_range / speed

var instigator: Node = null:
	set(value):
		instigator = value
		if faction == Enums.Faction.PLAYER:
			$Polygon2D.color = friendly_color
		else:
			$Polygon2D.color = hostile_color

var faction: Enums.Faction:
	get:
		if instigator:
			return instigator.faction
		return Enums.Faction.PLAYER

var dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	if lifetime > 0.0:
		$LifetimeTimer.start(lifetime)

func _process(delta: float) -> void:
	position += dir * speed * delta

func _on_lifetime_timer_timeout() -> void:
	queue_free()

func collided():
	queue_free()
