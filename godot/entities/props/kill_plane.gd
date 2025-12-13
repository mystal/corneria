class_name KillPlane
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	var clean_up_box := area as CleanUpBox
	clean_up_box.clean_up.emit()
