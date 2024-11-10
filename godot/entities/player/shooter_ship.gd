class_name ShooterShip
extends CharacterBody2D

@export_group("Movement")
# @export var _speed = 300.0

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_rate: float = 2.0

var faction: Enums.Faction = Enums.Faction.PLAYER

@onready var _fire_cooldown: float = 1.0 / fire_rate

signal ship_died(ship: ShooterShip)

func _physics_process(delta: float) -> void:
	_fire_cooldown -= delta
	if _fire_cooldown <= 0.0:
		# Spawn projectile
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.instigator = self
		new_projectile.position = global_position
		new_projectile.dir = Vector2.UP
		get_tree().current_scene.add_child(new_projectile)

		# Reset cooldown
		_fire_cooldown = 1.0 / fire_rate

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var projectile = area as Projectile
	if projectile and projectile.faction != faction:
		queue_free()
		ship_died.emit(self)
		projectile.collided()
