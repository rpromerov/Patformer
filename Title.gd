extends HBoxContainer

func _on_PlayButton_pressed():
	print ("playing")
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_LevelSelectButton_pressed():
	get_tree().change_scene("res://Menu/Level Select.tscn")

func _process(delta):
	if Input.is_action_pressed("ui_page_up"):
		get_tree().change_scene("res://World.tscn")