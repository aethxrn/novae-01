extends CanvasLayer

func _on_Back_pressed():
	queue_free()
	get_node("../MainMenu/Title").show()
	get_node("../MainMenu/Start").show()
	get_node("../MainMenu/Credit").show()
