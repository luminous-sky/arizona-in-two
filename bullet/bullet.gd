extends Area2D

@export var damage = 1 #Bullet's damage
@export var effects = ["fire","ice"] #Bullet's effects

@export var direction = Vector2() # bullet direction of travel

var speed = 128 #The speed of the bullet

func _physics_process(delta):
	position += speed * direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	call_deferred("queue_free")
