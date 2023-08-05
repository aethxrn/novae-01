extends Area2D

var pHitEffect = preload("res://Scenes/Hit-01.tscn")

export var speed = 0

func _physics_process(delta):
	position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.is_in_group("enemies"):
		var hitEffect = pHitEffect.instance()
		hitEffect.position = position
		get_parent().add_child(hitEffect)
		hitEffect.play("hit")
		area.damage(1)
		Signals.emit_signal("on_score_increment", 10)
		queue_free()
