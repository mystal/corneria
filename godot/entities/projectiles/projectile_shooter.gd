class_name ProjectileShooter
extends Node2D

enum FireBehavior {
	## The Shooter will automatically fire when not on cooldown.
	AUTO,
	## The Shooter can request to shoot, limited by its fire rate cooldown.
	AT_WILL,
}

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_behavior: FireBehavior = FireBehavior.AUTO
@export var fire_rate: float = 2.0
@export var initial_cooldown: float = 0.0
@export var projectile_range: float = 600.0
@export var projectile_speed: float = 600.0
@export var direction: Vector2 = Vector2.UP

@onready var _fire_cooldown: float = initial_cooldown

var instigator: Node2D

func _process(delta: float) -> void:
	if !projectile_scene:
		return

	_fire_cooldown = max(_fire_cooldown - delta, 0.0)
	if fire_behavior == FireBehavior.AUTO:
		fire()

func fire() -> void:
	if _fire_cooldown > 0.0:
		return

	# Spawn projectile
	var new_projectile: Projectile = projectile_scene.instantiate()
	new_projectile.instigator = instigator
	new_projectile.position = global_position
	new_projectile.speed = projectile_speed
	new_projectile.max_range = projectile_range
	new_projectile.dir = direction
	get_tree().current_scene.add_child(new_projectile)

	# Reset cooldown
	_fire_cooldown = 1.0 / fire_rate if fire_rate > 0.0 else 0.0
