extends Node2D

var Enemy = preload("res://Scenes/Enemy-01.tscn")

onready var spawnTimer := $SpawnTimer

var nextSpawnTime : = rand_range(0.5, 1)

func _on_SpawnTimer_timeout():
	var xPos = rand_range(16, 240)
	var enemy = Enemy.instance()
	enemy.position = Vector2(xPos, position.y)
	get_parent().add_child(enemy)
	spawnTimer.start(nextSpawnTime)

func _on_Start_pressed():
	spawnTimer.start(nextSpawnTime)
