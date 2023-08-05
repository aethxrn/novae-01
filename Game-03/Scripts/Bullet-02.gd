extends Area2D

var pHitEffect = preload("res://Scenes/Hit-01.tscn")
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var speed2 = rand_range(150, 250)
var speed3 = rand_range(-100, 100)

#onready var player = get_parent().get_node("Player"
#prototype made by abieza ananta

func _physics_process(delta):
	position.y += speed2 * delta
	position.x += speed3 * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area is Player:
		var hitEffect = pHitEffect.instance()
		hitEffect.play("hit")
		hitEffect.position = position
		get_parent().add_child(hitEffect)
		area.damage(1)
		queue_free()
