extends CanvasLayer

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	queue_free()
