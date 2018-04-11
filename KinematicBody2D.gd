extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0,-1)
const GRAVITY = 20
const  ACCELERATION = 250
const MAX_SPEED = 700
const JUMP_HEIGHT = -500
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = ACCELERATION
		if motion.x > MAX_SPEED:
			motion.x = MAX_SPEED
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -ACCELERATION
		if motion.x < -MAX_SPEED:
			motion.x = -MAX_SPEED 
		
	if is_on_floor():
		motion.x *= 0.95
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		motion.x *= 0.97
	motion = move_and_slide(motion, UP) 
