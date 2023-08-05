extends Area2D

var plBullet = preload("res://Scenes/Bullet-02.tscn")
var plExplosion = preload("res://Scenes/Explosion-01.tscn")

onready var gun = $Gun
onready var cdTimer = $Cooldown
onready var sound_effect = $SFX

export var verticalSpeed = 0
export var health = 0
var cooldown = rand_range(0.1, 0.25)

var playerInArea: Player = null

func _physics_process(delta):
	position.y += verticalSpeed * delta
	
func _process(delta):
	if cdTimer.is_stopped():
		fire()
		cdTimer.start(cooldown)
	if playerInArea != null:
		var explode = plExplosion.instance()
		explode.position = position
		get_parent().add_child(explode)
		explode.play("explosion")
		playerInArea.damage(1)
		queue_free()
		Signals.emit_signal("on_score_increment", 100)

func fire():
	sound_effect.play()
	var bullet = plBullet.instance()
	bullet.global_position = gun.global_position
	get_tree().get_root().get_node("Main/Gameplay").add_child(bullet)
	
func damage(amount: int):
	if health <= 0:
		return
	health -= amount
	if health <= 0:
		var explode = plExplosion.instance()
		explode.position = position
		get_parent().add_child(explode)
		explode.play("explosion")
		Signals.emit_signal("on_score_increment", 100)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
