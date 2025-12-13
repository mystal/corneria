class_name Health
extends Node

signal health_changed(old: float, new: float)
signal fully_healed()
signal died()

#TODO: Consider making an Attribute class, similar to Attributes in GAS.

@export var max_health: float

var current: float = max_health

func _ready() -> void:
	max_health = max(max_health, 0.0)
	current = max_health

## Returns how much damage was actually taken.
func take_damage(amount: float) -> float:
	var to_take := clampf(amount, 0.0, current)
	var original_health := current
	current -= to_take
	if to_take > 0.0:
		health_changed.emit(original_health, current)
		if current <= 0.0:
			died.emit()
	return to_take

## Returns how much health was actually gained.
func heal(amount: float) -> float:
	var to_heal := clampf(amount, 0.0, missing())
	var original_health := current
	current += to_heal
	if to_heal > 0.0:
		health_changed.emit(original_health, current)
		if current == max_health:
			fully_healed.emit()
	return to_heal

func missing() -> float:
	return max_health - current
