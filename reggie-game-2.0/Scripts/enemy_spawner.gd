extends Node2D

class_name enemy_spawner


func load_scene(scene_name: String) -> Node:
	var path = "res://Scenes/Enemies/%s.tscn" % scene_name 
	path = "res://Scenes/Enemies/placeholder.tscn"
	var scene_res = load(path)
	
	if scene_res is PackedScene:
		return scene_res.instantiate()
	else: 
		push_error("Scene not found or not a valid PackedScene: " + path)
		return null

func calculateposition(midpoint: Vector2, spawnradius: float, mindistance: float):
	var angle = randf_range(-PI, PI)
	var distance = randf_range(mindistance, spawnradius)
	
	return midpoint + Vector2.RIGHT.rotated(angle) * distance
	
func SpawnEnemies(Type: String, Position: Vector2):
	var enemy = load_scene(Type)
	print("Enemy!: ", enemy)
	add_child(enemy)
	enemy.transform = transform
	enemy.global_position = Position
	
	print("Enemy position: ", enemy.position)
	print("Enemy name: ", enemy.name)
	
