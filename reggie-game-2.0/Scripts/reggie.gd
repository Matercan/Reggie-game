extends CharacterBody2D

class_name Player

@export var move_speed : float = 100
@export var drag : float = 0.95
@export var acceleration : float = 0.1
@export var projectile: PackedScene
@export var gun: Node2D
@export var Maxhealth: float = 100
@export var Health: float = 100
@export var DeathMenu: Node

func _ready():
	add_to_group("Player")
	$Sprite2D/AnimationPlayer.play("RESET")
	Health = 100
	
func has_variable(node: Object, var_name: String) -> bool:
	return var_name in node.get_property_list().map(func(p): return p.name)


func _physics_process(_delta) -> void:
	move()
	if Health <= 0: die()
	
func  die() -> void:
	DeathMenu.pause()

func move() -> void:
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	input_direction = input_direction.normalized() # makes it so diagonal dirs aren't faster
	
	#calculate velocity
	if !velocity.length() > move_speed: # speed cap
		velocity += input_direction * move_speed * acceleration
		
	velocity *= drag
	
	
	#Move reggie on screen
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void: # checks if something interacts with hitbox
	if !area.is_in_group("Hurtbox"): return
	var Animp = $Sprite2D/AnimationPlayer
	Animp.play("flash")
	var enemy = area.owner
	print("Area entered: ", area.name)
	print("Enemy candidate:", enemy.name)
		
	if enemy.is_in_group("Enemytypes"):
		print("It's an enemy")
		if enemy.name == "Placeholder":
			print("Enemy detected: Placholder")
			if enemy.base.timer > enemy.base.attackcooldown: # If ccooldown has passed
				enemy.base.dealdamage(0, self) #deals damage type 0 to yourself 
				var dir = (enemy.global_position - global_position).normalized()
				velocity += dir * enemy.base.knockback[0] # knockback's reggie
				enemy.base.timer = 0
	else: # projectile scripts in future
		pass
		
		
		
