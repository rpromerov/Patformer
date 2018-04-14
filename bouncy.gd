extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print ( body)
		
		
		body.motion.y = -1000
		body.motion.x = 20

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
