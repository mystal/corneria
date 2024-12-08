class_name RunManager
extends Node2D

@export_group("Stages")
@export var num_stages: int = 3

@export_group("Encounters")
@export var num_encounters_per_stage: int = 3
@export var encounter_height: float = 1280.0

var _stages: Array[RunStage] = []

var _current_stage: int = -1
var _current_encounter: int = -1

func _ready() -> void:
	# Generate run up-front for now!
	var scene_root := get_tree().current_scene
	var screen_center: float = 720.0 / 2.0

	for i in range(num_stages):
		var new_stage := RunStage.new()
		new_stage._manager = self
		new_stage.id = i

		for j in range(num_encounters_per_stage):
			var encounter_start_y := ((i * num_encounters_per_stage) + j) * -encounter_height

			var new_encounter := RunEncounter.new()
			new_encounter._manager = self
			new_encounter.id = j
			# Boss at the last encounter of a stage
			new_encounter.is_boss_encounter = j == num_encounters_per_stage - 1

			# Spawn encounter entities!

			if not new_encounter.is_boss_encounter:
				# Spawn normal wave of enemies
				var enemy: Enemy = preload("res://entities/enemies/enemy.tscn").instantiate()
				enemy.position.x = randf_range(50.0, 720.0 - 50.0)
				enemy.position.y = encounter_start_y - randf_range(50.0, 1280.0 - 50.0)
				enemy.should_shoot = i > 0
				scene_root.add_child.call_deferred(enemy)
			else:
				# Spawn boss, possibly with an enemy
				var boss: Enemy = preload("res://entities/enemies/boss.tscn").instantiate()
				boss.position.x = screen_center
				boss.position.y = encounter_start_y - (1280.0 - 380.0)
				scene_root.add_child.call_deferred(boss)

			# Spawn upgrade wall at the end
			var upgrade_wall: UpgradeWall = preload("res://entities/upgrades/upgrade_wall.tscn").instantiate()
			# TODO: Generate random upgrades!
			upgrade_wall.left_upgrade = preload("res://entities/upgrades/resources/modify_shoot_range.tres")
			upgrade_wall.right_upgrade = preload("res://entities/upgrades/resources/modify_shoot_rate.tres")
			upgrade_wall.position.x = screen_center
			upgrade_wall.position.y = encounter_start_y - (1280.0 - 50.0)
			scene_root.add_child.call_deferred(upgrade_wall)

			new_stage.encounters.append(new_encounter)

		_stages.append(new_stage)

	# Spawn initial upgrade wall!
	# TODO: With two better upgrades than normal.
	var initial_upgrade_wall: UpgradeWall = preload("res://entities/upgrades/upgrade_wall.tscn").instantiate()
	# TODO: Generate random upgrades!
	initial_upgrade_wall.left_upgrade = preload("res://entities/upgrades/resources/modify_shoot_range.tres")
	initial_upgrade_wall.right_upgrade = preload("res://entities/upgrades/resources/modify_shoot_rate.tres")
	initial_upgrade_wall.position.x = screen_center
	initial_upgrade_wall.position.y = 300.0
	scene_root.add_child.call_deferred(initial_upgrade_wall)

	_current_stage = 0
	_current_encounter = 0

func _process(_delta: float) -> void:
	pass
