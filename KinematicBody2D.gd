extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0,-1)
const GRAVITY = 20
const  ACCELERATION = 180
const MAX_SPEED = 240
const JUMP_HEIGHT = -500
var motion = Vector2()
var i = 0
var c = 0
func _physics_process(delta):
	motion.y += GRAVITY
	
#	if Input.is_action_pressed("ui_right"):
#		motion.x = ACCELERATION
#		if motion.x > MAX_SPEED:
#			motion.x = MAX_SPEED
#
#	elif Input.is_action_pressed("ui_left"):
#		motion.x = -ACCELERATION
#		if motion.x < -MAX_SPEED:
#			motion.x = -MAX_SPEED 
#
	
	if is_on_floor():
		i = 0
		c = 0
		if motion.x > MAX_SPEED:
			motion.x *= 0.95
		
		else:
			motion.x = ACCELERATION
				
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if Input.is_action_just_pressed("ui_right"):
			motion.x= ACCELERATION*5
	else:
		if motion.x > MAX_SPEED:
			motion.x *= 0.95
		else:
			motion.x = ACCELERATION*0.9
		if Input.is_action_just_pressed("ui_up") and i == 0:
			motion.y= JUMP_HEIGHT
			i = 1
		elif Input.is_action_just_pressed("ui_right")and c == 0:
			motion.x = ACCELERATION*4
			c = 1
		motion.x *= 1
		
	motion = move_and_slide(motion, UP) 
