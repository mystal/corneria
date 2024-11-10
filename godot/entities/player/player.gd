class_name Player
extends Node2D

@export_group("Init")
@export var starter_ships: Array[StarterShips] = []

@export_group("Movement")
@export var top_left_limit: Node2D
@export var bottom_right_limit: Node2D

@export_group("Ship Management")
@export var spacing: float = 60

var _ships: Array[ShooterShip] = []

func _ready() -> void:
	for e in starter_ships:
		if e.ship_scene:
			add_ships(e.ship_scene, e.num_ships)

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

	# if Input.is_action_just_pressed("ui_accept") and starter_ships and starter_ships[0].ship_scene:
	# 	add_ships(starter_ships[0].ship_scene, 1)

	# Mouse/Touch input
	var mouse_pos = get_global_mouse_position()
	# TODO: Figure out how to tune the movement so that we can upgrade the move speed.
	position = position.lerp(mouse_pos, delta * 4.0)
	if top_left_limit and bottom_right_limit:
		position = position.clamp(top_left_limit.position, bottom_right_limit.position)
	# var viewport_rect = get_viewport_rect()
	# if viewport_rect.has_point(mouse_pos):
		# var dv = position.distance_to(mouse_pos)
		# position = position.move_toward(mouse_pos, _speed * delta)

func add_ships(ship_scene: PackedScene, num_ships: int) -> void:
	for i in num_ships:
		var new_ship = ship_scene.instantiate()
		new_ship.ship_died.connect(_on_ship_died)
		add_child(new_ship)
		_ships.append(new_ship)
	_distribute_ships()

func _distribute_ships() -> void:
	var total_spacing = (_ships.size() - 1) * spacing
	var start_x = -total_spacing / 2
	for i in _ships.size():
		_ships[i].position.x = start_x + (spacing * i)

func _on_ship_died(ship: ShooterShip) -> void:
	_ships.erase(ship)
	_distribute_ships()

	if _ships.is_empty():
		Globals.player_lost()
