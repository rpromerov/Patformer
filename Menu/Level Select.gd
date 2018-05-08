extends MarginContainer


func _on_BackButton_pressed():
	get_tree().change_scene("res://Title.tscn")

func _on_Tutorial_pressed():
	get_tree().change_scene("res://Levels/Tutorial.tscn")

func _on_Level_1_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_MenuButton3_pressed():
	$VBoxContainer/MenuButton3.text="no"
