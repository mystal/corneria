class_name UpgradeLoot
extends Area2D

@export var upgrade: UpgradeData:
	set(value):
		upgrade = value
		_update_visuals()

func _ready() -> void:
	_update_visuals()

func _process(delta: float) -> void:
	position.y += Globals.game_speed * delta

func _on_area_entered(area: Area2D) -> void:
	if upgrade:
		upgrade.apply(area.get_parent() as Player)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("picked_up")

func _update_visuals() -> void:
	if upgrade:
		$Label.text = upgrade.description()
		$Polygon2D.color.r = upgrade.color.r
		$Polygon2D.color.g = upgrade.color.g
		$Polygon2D.color.b = upgrade.color.b
	else:
		$Label.text = "Empty"

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
