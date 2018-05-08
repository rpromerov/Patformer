extends Node

onready var tutlabel=$"Tutorial GUI/Label"

func _on_Trigger1_body_entered(body): #Saltar
	tutlabel.text="Flecha arriba para saltar"

func _on_Trigger2_body_entered(body): #Doble salto
	tutlabel.text="Flecha arriba (x2) para doble salto"

func _on_Trigger3_body_entered(body): #Agacharse
	tutlabel.text="Flecha abajo para agacharse"
	
func _on_Trigger4_body_entered(body): #Especial 1
	tutlabel.text="Toca el bloque para saltar más alto"

func _on_Trigger5_body_entered(body): #Peligro 1
	tutlabel.text="Flecha derecha para correr más rápido"

func _on_Meta_body_entered(body):
	get_tree().change_scene("res://Title.tscn")

func _ready():
	$Player.currentlevel="res://Levels/Tutorial.tscn"