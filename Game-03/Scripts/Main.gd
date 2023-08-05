extends Node

var credit = preload("res://Scenes/Credit.tscn")

func _on_Credit_pressed():
	var credit_instance =  credit.instance() 
	get_node("UI").add_child(credit_instance)
