class_name RunManager
extends Node2D

@export_group("Stages")
@export var num_stages: int = 3

@export_group("Encounters")
@export var num_encounters_per_level: int = 3

var _current_stage: RunStage

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if not _current_stage:
		# Start first stage and encounter.
		_current_stage = RunStage.new()
		_current_stage.manager = self
		_current_stage.id = 0
		var new_encounter = RunEncounter.new()
		new_encounter.manager = self
		new_encounter.id = 0
		_current_stage.current_encounter = new_encounter
