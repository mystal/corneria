class_name PlayerMovement
extends Node2D

@export_group("Movement")
@export var lerp_speed: float = 4.0
@export var top_left_limit: Node2D
@export var bottom_right_limit: Node2D

var root: Node2D

func _process(delta: float) -> void:
	if !root:
		return

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
	var mouse_pos := get_global_mouse_position()
	# TODO: Figure out how to tune the movement so that we can upgrade the move lerp_speed.
	root.position = root.position.lerp(mouse_pos, delta * lerp_speed)
	if top_left_limit and bottom_right_limit:
		root.position = root.position.clamp(top_left_limit.position, bottom_right_limit.position)
	# var viewport_rect = get_viewport_rect()
	# if viewport_rect.has_point(mouse_pos):
		# var dv = position.distance_to(mouse_pos)
		# position = position.move_toward(mouse_pos, _speed * delta)
