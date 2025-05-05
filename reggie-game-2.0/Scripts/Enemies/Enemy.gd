extends Node2D

class_name Base_Enemy

@export var Health: float
@export var Maxhealth: float
@export var velocity: float
@export var base_knockback: float
@onready var timer: float = 0
@export var attackcooldown: float
@export var knockback = Array([], TYPE_FLOAT, "", null)
@export var damage = Array([], TYPE_FLOAT, "", null)
@export var damagetype = Array([], TYPE_STRING, "", null)


func has_variable(node: Object, var_name: String) -> bool:
	return var_name in node.get_property_list().map(func(p): return p.name)
		
func takedamage(amount: float, incomingdir: Vector2, attack_knockback: float) -> void:
	Health -= amount
	position -= incomingdir * amount * base_knockback * attack_knockback
	
func movetotarget(speed: float, from: Vector2, to: Vector2, delta: float) -> Vector2:
	var dir: Vector2 = (to - from).normalized()
	print("Enemy Direction: ", dir)
	return dir * delta * speed
	
func dealdamage(method: int, to: Node):
	print("Target: ", to)
	if !has_variable(to, "Health") or !has_variable(to, "velocity"):
		print("Target not Damage Takable")
		return
	
	to.Health -= damage[method]
	
	var dir = (to.global_position - position).normalized()
	to.velocity += dir * knockback[method]
	
func _process(delta: float) -> void:
	
	timer += delta
