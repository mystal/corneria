class_name Enemy
extends CharacterBody2D

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_rate: float = 2.0

var faction: Enums.Faction = Enums.Faction.ENEMY

@onready var _fire_cooldown: float = randf_range(1.0, 3.0)

func _physics_process(delta: float) -> void:
	_fire_cooldown -= delta
	if _fire_cooldown <= 0.0:
		# Spawn projectile
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.instigator = self
		new_projectile.position = position
		new_projectile.dir = Vector2.DOWN
		get_tree().current_scene.add_child(new_projectile)

		# Reset cooldown
		_fire_cooldown = randf_range(1.0, 3.0)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is Projectile and area.faction != faction:
		queue_free()
