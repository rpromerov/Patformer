extends MarginContainer


func _on_BackButton_pressed():
	get_tree().change_scene("res://Title.tscn")

func _on_Tutorial_pressed():
	get_tree().change_scene("res://Levels/Tutorial.tscn")
