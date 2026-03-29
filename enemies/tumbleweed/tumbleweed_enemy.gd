extends CharacterBody2D

@export var speed: float = 10.0

@export var attackDmg: float = 10.0

var minDist: float = 15.0

var maxDist: float = 25.0

var targetPosition := position

var targetAngle: Vector2 = Vector2(0, 0)

var player: CharacterBody2D = null

var spread: float = PI/6

var mode: String = "Idle"

@onready var timer: Timer = $"Movement Timer"
@onready var attackTimer: Timer = $"Attack Delay"

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if mode == "Idle":
		if position == targetPosition:
			velocity = Vector2(0,0)
			timer.start()
		
		if timer.is_stopped():
			velocity = targetAngle * speed
		
		move_and_slide()
	elif mode == "Attack":
		attack()

func movement():
	var direction: Vector2 = [Vector2(1,0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)][randi_range(0,3)]
	var distance: float = randf_range(minDist, maxDist)
	
	targetPosition = position - (direction * distance)

func attack():
	if attackTimer.is_stopped():
		attackTimer.start()

func damaged_sequence():
	pass # Hurt Animation

func suicide():
	queue_free() # Death Animation


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("Player"):
		player = body
		mode = "Attack"
		timer.stop()

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("Player"):
		player = null
		mode = "Idle"
		timer.start()


func _on_movement_timer_timeout() -> void:
	if position == targetPosition:
		movement()


func _on_attack_delay_timeout() -> void:
	var bullet1 = load("res://enemies/tumbleweed/tumble_bullet.tscn").instantiate()
	var bullet2 = load("res://enemies/tumbleweed/tumble_bullet.tscn").instantiate()
	var bullet3 = load("res://enemies/tumbleweed/tumble_bullet.tscn").instantiate()
	
	bullet1.position = position
	bullet2.position = position
	bullet3.position = position
	
	bullet1.direction = player.position - position
	bullet2.direction = (player.position - position).rotated(spread)
	bullet2.direction = (player.position - position).rotated(-spread)
	
	get_parent().add_child(bullet1)
	get_parent().add_child(bullet2)
	get_parent().add_child(bullet3)
