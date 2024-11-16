class_name ProjectileShooter
extends Node2D

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_rate: float = 2.0
@export var projectile_range: float = 600.0
@export var projectile_speed: float = 600.0
@export var direction: Vector2 = Vector2.UP

@onready var _fire_cooldown: float = 1.0 / fire_rate

var instigator: Node2D

func _process(delta: float) -> void:
	if !projectile_scene:
		return

	_fire_cooldown -= delta
	if _fire_cooldown <= 0.0:
		# Spawn projectile
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.instigator = instigator
		new_projectile.position = global_position
		new_projectile.speed = projectile_speed
		new_projectile.max_range = projectile_range
		new_projectile.dir = direction
		get_tree().current_scene.add_child(new_projectile)

		# Reset cooldown
		_fire_cooldown = 1.0 / fire_rate
