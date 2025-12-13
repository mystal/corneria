class_name Enemy
extends CharacterBody2D

# TODO: Health
# @export_group("Health")
# @export var health: int = 10

@export var should_shoot: bool = false

@export_group("Loot")
@export var loot_category: Enums.LootCategory = Enums.LootCategory.BASIC

var faction: Enums.Faction = Enums.Faction.ENEMY

# Components
@onready var projectile_shooter: ProjectileShooter = $ProjectileShooter
@onready var health: Health = $Health

func _ready() -> void:
	projectile_shooter.instigator = self
	projectile_shooter.fire_behavior = Enums.FireBehavior.AUTO if should_shoot else Enums.FireBehavior.AT_WILL

func _physics_process(delta: float) -> void:
	# Move first
	position.y += Globals.game_speed * delta

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var projectile := area as Projectile
	if projectile and projectile.faction != faction:
		health.take_damage(projectile.damage)
		projectile.collided()

func _on_health_died() -> void:
	# Spawn loot.
	var loot_upgrade := Globals.pick_loot_for(loot_category)
	var packed_loot_scene := preload("res://entities/upgrades/upgrade_loot.tscn")
	var new_loot_scene := packed_loot_scene.instantiate() as UpgradeLoot
	new_loot_scene.position = global_position
	new_loot_scene.upgrade = loot_upgrade
	get_tree().current_scene.call_deferred("add_child", new_loot_scene)

	queue_free()

func _on_clean_up_box_clean_up() -> void:
	queue_free()
