class_name DebugUi
extends Control

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var player := get_tree().get_nodes_in_group("players").front() as Player
	if player:
		var player_stats := "[Player Stats]"
		player_stats += "\nHealth: %.1f / %.1f" % [player.health.current, player.health.max_health]
		player_stats += "\nFire Rate: %.1f" % player.projectile_shooter.fire_rate
		player_stats += "\nProjectile Speed: %.1f" % player.projectile_shooter.projectile_speed
		player_stats += "\nProjectile Range: %.1f" % player.projectile_shooter.projectile_range
		$Label.text = player_stats
