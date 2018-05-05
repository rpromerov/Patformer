extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0,-1)
const GRAVITY = 20
const  ACCELERATION = 190
const MAX_SPEED = 240
const JUMP_HEIGHT = -500
var motion = Vector2()
var i = 0
var c = 0
var hp = 1
var anim_flag=false
var objectsintheway=[]
var swipe_start = null
var minimum_drag = 100


func _ready():
	add_to_group("player")

func getKilled():
	hp = 0
	get_node("BodyCollision").position=Vector2(0,1500)
	get_node("CBodyCollision").position=Vector2(0,1500)
	get_node("GUI/Restart Message").visible=true
	$"Death Placeholder".play("Death")
	print("DEAD")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene("res://World.tscn")
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Title.tscn")
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
	if hp == 0:  #Esto no esta haciendo nada jaja
		pass

	if is_on_floor():
		i = 0
		c = 0
		if motion.x > MAX_SPEED:
			motion.x *= 0.95
		
		else:
			if hp == 1:
				motion.x = ACCELERATION
				
		if hp> 0:
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if Input.is_action_just_pressed("ui_right"):
				motion.x= ACCELERATION*5
	else:
		if motion.x > MAX_SPEED:
			motion.x *= 0.95
		else:
			if hp == 1:
				motion.x = ACCELERATION
		if hp> 0:
			if Input.is_action_just_pressed("ui_up") and i == 0:
				motion.y= JUMP_HEIGHT
				i = 1
			elif Input.is_action_just_pressed("ui_right")and c == 0:
				motion.x = ACCELERATION*4
				c = 1
		motion.x *= 1
		
	motion = move_and_slide(motion, UP) 
	
	#-----ANIMATION-----
	if motion.y!=0 and objectsintheway.size()==0:
		get_node("AnimatedSprite").play("Falling")
		get_node("CBodyCollision").disabled=true
		get_node("BodyCollision").disabled=false
	elif motion.x>190 and Input.is_action_pressed("ui_down"):
		get_node("AnimatedSprite").play("Dashing_C")
		get_node("CBodyCollision").disabled=false
		get_node("BodyCollision").disabled=true
	elif Input.is_action_pressed("ui_down"):
		get_node("AnimatedSprite").play("Crouched")
		get_node("CBodyCollision").disabled=false
		get_node("BodyCollision").disabled=true
	elif motion==Vector2(0,0) and objectsintheway.size()!=0 and Input.is_action_pressed("ui_down"):
		get_node("AnimatedSprite").play("Idle_C")
		get_node5("CBodyCollision").disabled=false
		get_node("BodyCollision").disabled=true
	elif motion==Vector2(0,0) and not Input.is_action_pressed("ui_down"):
		get_node("AnimatedSprite").play("Idle")
		get_node("CBodyCollision").disabled=true
		get_node("BodyCollision").disabled=false
	elif motion.x>190 and objectsintheway.size()==0:
		get_node("AnimatedSprite").play("Dashing")
		get_node("CBodyCollision").disabled=true
		get_node("BodyCollision").disabled=false
	elif motion!=Vector2(0,0) and objectsintheway.size()==0:
		get_node("AnimatedSprite").play("Running")
		get_node("CBodyCollision").disabled=true
		get_node("BodyCollision").disabled=false

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		swipe_start = get_viewport().get_mouse_position()
	if event.is_action_released("click"):
		calculate_swipe(get_viewport().get_mouse_position())

func calculate_swipe(swipe_end):
	if swipe_start == null:
		return 
	var swipe = swipe_end - swipe_start
	print(swipe)
	if abs(swipe.y) > minimum_drag:
		if swipe.y < 0:
			Input.action_press("ui_up")
		else:
			Input.action_press("ui_down")
			$CrouchTimer.start()
	if abs(swipe.x) > minimum_drag:
		if swipe.x >0:
			Input.action_press("ui_right")
		else:
			Input.action_press("ui_left")

func _on_HeadDetection_body_entered(body): #Esto es para detectar si es que hay un bloque arriba del jugador
	if not body.is_in_group("player"):
		objectsintheway.append(body)       #Asi no se puede parar a menos que haya espacio
		print("Object entered head zone")
		print("Object:",body)
	
func _on_HeadDetection_body_exited(body):
	objectsintheway.erase(body)

func _on_CrouchTimer_timeout():
	Input.action_release("ui_down")
