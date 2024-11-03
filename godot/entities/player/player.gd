class_name Player
extends CharacterBody2D

@export_group("Movement")
# @export var _speed = 300.0

@export_group("Shooter")
@export var projectile_scene: PackedScene
@export var fire_rate: float = 2.0

var faction: Enums.Faction = Enums.Faction.PLAYER

@onready var _fire_cooldown: float = 1.0 / fire_rate

func _physics_process(delta: float) -> void:
	# TODO: Keyboard/Controller input
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * _speed
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, _speed)
	#move_and_slide()

	# Mouse/Touch input
	var mouse_pos = get_global_mouse_position()
	position = position.lerp(mouse_pos, delta * 4.0)
	# var viewport_rect = get_viewport_rect()
	# if viewport_rect.has_point(mouse_pos):
		# var dv = position.distance_to(mouse_pos)
		# position = position.move_toward(mouse_pos, _speed * delta)

	_fire_cooldown -= delta
	if _fire_cooldown <= 0.0:
		# Spawn projectile
		var new_projectile: Projectile = projectile_scene.instantiate()
		new_projectile.instigator = self
		new_projectile.position = position
		new_projectile.dir = Vector2.UP
		get_tree().current_scene.add_child(new_projectile)

		# Reset cooldown
		_fire_cooldown = 1.0 / fire_rate
