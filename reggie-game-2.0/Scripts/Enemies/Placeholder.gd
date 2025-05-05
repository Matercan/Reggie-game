extends StaticBody2D

var base = Base_Enemy.new()

@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@onready var area = get_node("Area2D")

func _ready() -> void:
	base.velocity = 50
	base.damage = [15.0, 0.0, 0.0]
	base.knockback = [200]
	base.attackcooldown = 1
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	position += base.movetotarget(base.velocity, global_position, reggie.position, delta)
	
func _on_body_entered(body):
	if base.timer < base.attackcooldown:
		"Attack on target cooldown not passed"
		return
	base.dealdamage(0, body)
	base.timer = 0
