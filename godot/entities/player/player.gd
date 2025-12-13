class_name Player
extends Node2D

@export_group("Movement")
@export var top_left_limit: Node2D
@export var bottom_right_limit: Node2D

var faction: Enums.Faction = Enums.Faction.PLAYER

# Components
@onready var player_movement: PlayerMovement = $PlayerMovement
@onready var projectile_shooter: ProjectileShooter = $ProjectileShooter
@onready var health: Health = $Health

# @export_group("Ship Management")
# @export var starter_ships: Array[StarterShips] = []
# @export var spacing: float = 60

# var _ships: Array[ShooterShip] = []

func _ready() -> void:
	player_movement.root = self
	player_movement.top_left_limit = top_left_limit
	player_movement.bottom_right_limit = bottom_right_limit

	projectile_shooter.instigator = self

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		projectile_shooter.fire()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var projectile := area as Projectile
	if projectile and projectile.faction != faction:
		health.take_damage(projectile.damage)
		projectile.collided()

func _on_health_died() -> void:
	queue_free()

# func add_ships(ship_scene: PackedScene, num_ships: int) -> void:
# 	for i in num_ships:
# 		var new_ship = ship_scene.instantiate()
# 		new_ship.ship_died.connect(_on_ship_died)
# 		add_child(new_ship)
# 		_ships.append(new_ship)
# 	_distribute_ships()

# func _distribute_ships() -> void:
# 	var total_spacing = (_ships.size() - 1) * spacing
# 	var start_x = -total_spacing / 2
# 	for i in _ships.size():
# 		_ships[i].position.x = start_x + (spacing * i)

# func _on_ship_died(ship: ShooterShip) -> void:
# 	_ships.erase(ship)
# 	_distribute_ships()

# 	if _ships.is_empty():
# 		Globals.player_lost()
