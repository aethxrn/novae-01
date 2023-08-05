extends Button

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
	 self.emit_signal("pressed");
