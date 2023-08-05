extends Node2D

var player = preload("res://Scenes/Player.tscn")
var bgm = preload("res://Scenes/BGM.tscn")

func _on_Start_pressed():
	var player_instance =  player.instance() 
	self.add_child(player_instance)
	player_instance.position = Vector2(128.0, 256.0)
	get_node("../MenuTheme").queue_free()
	var bgm_instance =  bgm.instance() 
	self.add_child(bgm_instance)

