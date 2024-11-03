class_name Player
extends CharacterBody2D

@export_group("Movement")
# @export var _speed = 300.0

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
