extends Control

@onready var reggie: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float) -> void:
	pass
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	$AudioStreamPlayer.stop()
	print("Resume")
	
	
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	$AudioStreamPlayer.play()
	print("Pause")

func _on_restart_pressed() -> void:
	if reggie.Health >= 0: return
	print("dead + restart")
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	if reggie.Health >= 0: return
	print("dead + quit")
	get_tree().quit()
