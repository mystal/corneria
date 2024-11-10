class_name Enemy
extends CharacterBody2D

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_rate: float = 2.0
@export var wants_to_fire: bool = true

# TODO: Health
# @export_group("Health")
# @export var health: int = 10

var faction: Enums.Faction = Enums.Faction.ENEMY

@onready var _fire_cooldown: float = randf_range(1.0, 3.0)

func _physics_process(delta: float) -> void:
	# Move first
	position.y += Globals.game_speed * delta
	# Despawn if we're outside the game space.
	if position.y > 1280.0 + 100.0:
		queue_free()

	# Then try to shoot
	_fire_cooldown -= delta
	if wants_to_fire and projectile_scene and _fire_cooldown <= 0.0:
		# Spawn projectile
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.instigator = self
		new_projectile.position = position
		new_projectile.dir = Vector2.DOWN
		get_tree().current_scene.add_child(new_projectile)

		# Reset cooldown
		_fire_cooldown = randf_range(1.0, 3.0)

func _exit_tree() -> void:
	# TODO: Spawn an upgrade.
	pass

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var projectile = area as Projectile
	if projectile and projectile.faction != faction:
		queue_free()
		projectile.collided()
