class_name Projectile
extends Area2D

@export_group("Movement")
@export_range(0.0, 2000.0, 5.0, "or_greater") var speed: float = 600.0
@export var max_range: float = 600.0

@export_group("Hit Spec")
@export var damage: float = 1.0

@export_group("Colors")
@export var friendly_color := Color.WHITE
@export var hostile_color := Color.ORANGE_RED

@onready var lifetime: float = max_range / speed

var instigator: Node = null:
	set(value):
		instigator = value
		if instigator:
			faction = instigator.faction

var faction: Enums.Faction:
	set(value):
		faction = value
		if faction == Enums.Faction.PLAYER:
			$Polygon2D.color = friendly_color
		else:
			$Polygon2D.color = hostile_color

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

func _on_clean_up_box_clean_up() -> void:
	queue_free()
