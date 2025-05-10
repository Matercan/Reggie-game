extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$VBoxContainer.visible = false


func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	$VBoxContainer.visible = false
	print("Resume")
	
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	$VBoxContainer.visible = true	
	print("Pause")
	
func testEsc():
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(_delta: float) -> void:
	testEsc()
