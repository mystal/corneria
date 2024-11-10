extends Node

@export var game_speed: float = 300.0
var game_status: Enums.GameStatus = Enums.GameStatus.PLAYING

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_WHEN_PAUSED

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		restart_game()

func is_game_over() -> bool:
	return game_status != Enums.GameStatus.PLAYING

func player_won() -> void:
	game_status = Enums.GameStatus.WON
	get_tree().paused = true
	var game_over_screen: GameOverScreen = get_tree().get_nodes_in_group("game_over")[0]
	game_over_screen.player_won()

func player_lost() -> void:
	game_status = Enums.GameStatus.LOST
	get_tree().paused = true
	var game_over_screen: GameOverScreen = get_tree().get_nodes_in_group("game_over")[0]
	game_over_screen.player_lost()

func restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
