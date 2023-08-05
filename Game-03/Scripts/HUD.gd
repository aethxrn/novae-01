extends Control

var pHealthIcon = preload("res://Scenes/HealthIcon.tscn")
var score = 0

onready var healthContainer = $Health/HealthContainer
onready var scoreLabel = $Score/Label

func _ready():
# warning-ignore:return_value_discarded
	Signals.connect("on_player_health_changed", self, "_on_player_health_changed")
# warning-ignore:return_value_discarded
	Signals.connect("on_score_increment", self, "_on_score_increment")
	
func clearHealth():
	for child in healthContainer.get_children():
		healthContainer.remove_child(child)
		child.queue_free()
		
func setHealth(health : int):
	clearHealth()
# warning-ignore:unused_variable
	for i in range(health):
		healthContainer.add_child(pHealthIcon.instance())
		
func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score).pad_zeros(9)

func _on_player_health_changed(health : int):
	setHealth(health)
