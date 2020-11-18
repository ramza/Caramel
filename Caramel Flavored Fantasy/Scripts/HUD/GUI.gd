# GUI
extends CanvasLayer

#The GUI is in charge of screen effects like transitions
# or screen flash

onready var curtain = get_node("Curtain")

func _ready():
	pass 


func Transition():
	curtain.FadeOut()

