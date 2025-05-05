extends StaticBody2D

var base = Base_Enemy.new()

@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@onready var area = get_node("Area2D")
var Health: float

func _ready() -> void:
	base.velocity = 50
	base.damage = [15.0, 0.0, 0.0]
	base.knockback = [200]
	base.attackcooldown = 1
	base.timer = 0
	base.Maxhealth = 100
	base.Health = base.Maxhealth
	Health = base.Health
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	position += base.movetotarget(base.velocity, global_position, reggie.position, delta)
	base.Health = Health
	base.timer += delta
	if Health <= 0: free()
	
	
func _on_body_entered(body):
	print("Target? Yes sir")
	if base.timer < base.attackcooldown:
		print("Time until I can attack target again: ", base.timer)
		print("Attack on target cooldown not passed")
		return
	base.dealdamage(0, body)
	base.timer = 0
	print("Target compromised")
	
