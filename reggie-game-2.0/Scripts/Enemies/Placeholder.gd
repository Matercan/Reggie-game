extends StaticBody2D

var base = Base_Enemy.new()

@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var Health: float
var Velocity: Vector2

func _ready() -> void:
	base.velocity = 50
	base.damage = [15.0, 0.0, 0.0]
	base.knockback = [200]
	base.attackcooldown = 1
	base.timer = 10
	base.Maxhealth = 100
	base.Health = base.Maxhealth
	Health = base.Health
	base.sprite = $Sprite2D
	base.AudioPlayer = $AudioStreamPlayer2D
	get_node("Hitbox").add_to_group("Hitbox")
	get_node("Hurtbox").add_to_group("Hurtbox")
	$Sprite2D/AnimationPlayer.play("RESET")
	add_to_group("Enemytypes")

func _physics_process(delta: float) -> void: # sets constants
	print("Health: ", Health)
	Velocity = base.movetotarget(Velocity, base.velocity, 15,
	 global_position, reggie.global_position, delta)
	position += Velocity
	base.Health = Health
	base.timer += delta
	if Health <= 0:
		print("Dead")
		free()
	
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("Hit") # if it's hit by a projectile, do the things
	if area.is_in_group("projectile"):
		var impact = area.get_node("Impact")
		
		if impact.stream: # plays the sound
			impact.stream_paused = false
			impact.play()
			impact.connect("finished", Callable(area, "_on_impact_finished"))
			print("Impact sound playing? ", impact.playing)
		else:
			print("No stream assigned to Impact!")
			
		Health -= 25 # takes away health
		get_node("Sprite2D/AnimationPlayer").play("flash") # plays the animation
		Velocity += (global_position - reggie.global_position).normalized() * area.knockback #knockback
		area.get_node("Sprite2D").visible = false #
	
