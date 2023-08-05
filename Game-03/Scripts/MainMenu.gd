extends CanvasLayer

func _on_Start_pressed():
	queue_free()

func _on_Credit_pressed():
	get_node("Title").hide()
	get_node("Start").hide()
	get_node("Credit").hide()
