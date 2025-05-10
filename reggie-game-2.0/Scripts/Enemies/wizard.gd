extends StaticBody2D

@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@export var Health: float
@export var Velocity: Vector2
@export var distance: float = 100
@export var base = Base_Enemy.new()
@export var Projectile: PackedScene

func _ready() -> void:
	base.velocity = 90
	base.damage = [30]
	base.knockback = [-300]
	base.attackcooldown = 2
	base.timer = 10
	base.Maxhealth = 50
	base.Health = base.Maxhealth
	Health = base.Health
	base.sprite = $Sprite2D
	base.AudioPlayer = $AudioStreamPlayer2D
	get_node("Hitbox").add_to_group("Hitbox")
	$Sprite2D/AnimationPlayer.play("RESET")
	add_to_group("Enemytypes")
	add_to_group("Wizard")

func calculatepos(ReggiePos: Vector2, Distance: float) -> Vector2:
	var dir = (global_position - ReggiePos).normalized()
	var targetpos = ReggiePos + dir * Distance
	if (global_position + targetpos - ReggiePos).length() <= (global_position - ReggiePos).length():
		return global_position
	else:
		return targetpos 
		
func shoot() -> void:
	if base.timer < base.attackcooldown: return
	#play sound
	var shot = $AudioStreamPlayer2D
	shot.pitch_scale = randf_range(0.9, 1.1)
	shot.play()
	
	#Spawn fireball
	var inst = Projectile.instantiate()
	inst.transform = self.transform
	inst.position = global_position
	inst.spawner = self
	get_parent().add_child(inst)
	
	#cooldown
	base.timer = 0
	
func die():
	queue_free()

func _physics_process(delta: float) -> void:
	Velocity = base.movetotarget(Velocity ,base.velocity, 10, position,
	 calculatepos(reggie.global_position, distance), delta)
	
	if (global_position - reggie.position).length() > distance - 1:
		shoot()
	if Health <= 0:
		die()
	
	base.timer += delta
	position += Velocity
	base.Health = Health
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Hit") # if it's hit by a projectile, do the things
	if area.is_in_group("projectile"):
		var impact = area.get_node("Impact")
		
		if impact.stream: # plays the sound
			impact.stream_paused = false
			impact.pitch_scale = randf_range(0.85, 1.15)
			impact.play()
			impact.connect("finished", Callable(area, "_on_impact_finished"))
			print("Impact sound playing? ", impact.playing)
		else:
			print("No stream assigned to Impact!")
			
		area.points += 25
		area.label.visible = true
		Health -= 25 # takes away health
		get_node("Sprite2D/AnimationPlayer").play("flash") # plays the animation
		Velocity += (global_position - reggie.global_position).normalized() * area.knockback #knockback
		area.get_node("Sprite2D").visible = false # # Replace with function body.
