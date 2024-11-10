class_name GameOverScreen
extends Control

func _ready() -> void:
	pass

func player_won() -> void:
	$Label.text = "You win!\nPress Spacebar to play again!"
	visible = true

func player_lost() -> void:
	$Label.text = "You lost :(\nPress Spacebar to try again!"
	visible = true
