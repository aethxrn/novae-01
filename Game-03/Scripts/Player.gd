extends Area2D
class_name Player

var vel = Vector2(0, 0)
var plBullet = preload("res://Scenes/Bullet-01.tscn")
var gameOver = preload("res://Scenes/GameOver.tscn")
var plExplosion = preload("res://Scenes/Explosion-01.tscn")

onready var animatedSprite = $AnimatedSprite
onready var guns = $Guns
onready var cdTimer = $Cooldown
onready var invTimer = $Invincibility
onready var soundEffect = $SFX

export var speed = 0
export var cd: float = 0
export var health = 0
export var damageInvTime = 0

func _ready():
	Signals.emit_signal("on_player_health_changed", health)

func _process(delta):
	if vel.x < 0:
		animatedSprite.play("left")
	elif vel.x > 0:
		animatedSprite.play("right")
	else:
		animatedSprite.play("default")
		
	if Input.is_action_pressed("shoot") and cdTimer.is_stopped():
		soundEffect.play()
		cdTimer.start(cd)
		for child in guns.get_children():
			var bullet = plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().get_root().get_node("Main/Gameplay").add_child(bullet)

func _physics_process(delta):
	var dirVec = Vector2(0, 0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		 dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1 
		
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	position.x = clamp(position.x, 16, 240)
	position.y = clamp(position.y, 24, 280)

func damage(amount :int):
	if !invTimer.is_stopped():
		return
		
	invTimer.start(damageInvTime)
	health -= amount
	Signals.emit_signal("on_player_health_changed", health)
	
	if health <=0:
		queue_free()
		var explode = plExplosion.instance()
		explode.position = position
		get_parent().add_child(explode)
		explode.play("explosion")
		var gameOver_instance =  gameOver.instance() 
		get_tree().get_root().add_child(gameOver_instance)
