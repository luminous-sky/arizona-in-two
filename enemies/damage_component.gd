extends Node
@export var health: float = 100.0

func accept_bullet_(bullet: Node):
	var damage = bullet.damage #exported damage
	var effects = bullet.effects #exported effects (string array)

func take_damage(damage: float):
	health = health - damage #take damage
	if(health <= 0):
		die()
	var parent = get_parent() # call parent _damaged_sequence()
	parent.damaged_sequence()

func die():
	pass
	var parent = get_parent() # call parent _suicide() method
	parent.suicide()
