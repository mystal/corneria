class_name Enemy
extends CharacterBody2D

# TODO: Health
# @export_group("Health")
# @export var health: int = 10

@export_group("Loot")
@export var loot_category: Enums.LootCategory = Enums.LootCategory.BASIC

var faction: Enums.Faction = Enums.Faction.ENEMY

# Components
@onready var projectile_shooter: ProjectileShooter = $ProjectileShooter

func _ready() -> void:
	projectile_shooter.instigator = self

func _physics_process(delta: float) -> void:
	# Move first
	position.y += Globals.game_speed * delta
	# Despawn if we're outside the game space.
	if position.y > 1280.0 + 100.0:
		queue_free()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var projectile = area as Projectile
	if projectile and projectile.faction != faction:
		died()
		projectile.collided()

func died() -> void:
	# Spawn loot.
	var loot_upgrade: UpgradeData = Globals.pick_loot_for(loot_category)
	var packed_loot_scene = preload("res://entities/upgrades/upgrade_loot.tscn")
	var new_loot_scene = packed_loot_scene.instantiate()
	new_loot_scene.position = global_position
	new_loot_scene.upgrade = loot_upgrade
	get_tree().current_scene.add_child(new_loot_scene)

	queue_free()
