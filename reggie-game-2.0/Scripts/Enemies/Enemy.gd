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

@onready var sprite


func has_variable(node: Object, var_name: String) -> bool:
	return var_name in node.get_property_list().map(func(p): return p.name)
		
func takedamage(amount: float, incomingdir: Vector2, attack_knockback: float) -> void:
	Health -= amount
	position -= incomingdir * amount * base_knockback * attack_knockback
	print(Health)
	print(position)
	
func movetotarget(current_speed: Vector2, max_speed: float, acceleration: float, from: Vector2, to: Vector2, delta: float) -> Vector2:
	var dir: Vector2 = (to - from).normalized()
	if dir.x != 0:
		sprite.scale.x = sign(dir.x) * abs(sprite.scale.x)
	#print("Enemy Direction: ", dir)
	print(current_speed)
	print(acceleration)
	if current_speed.length() <= max_speed * delta:
		print("It's working boss")
		current_speed += dir * delta * acceleration
		
	current_speed *= 0.95
	print(current_speed)
	return current_speed
	
func dealdamage(method: int, to: Node):
	print(damage[method])
	print(knockback[method])
	
	#print("Target: ", to)
	if !has_variable(to, "Health") or !has_variable(to, "velocity"):
		print("Target not Damage Takable")
		return
	
	to.Health -= damage[method]
	
	
	var dir = (to.global_position - position).normalized()
	to.velocity += dir * knockback[method]
	
