extends Node

func _ready():
	$Player.currentlevel="res://Levels/Level1.tscn"

func _on_Meta_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World.tscn")