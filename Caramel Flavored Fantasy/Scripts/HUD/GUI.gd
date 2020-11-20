# GUI
extends CanvasLayer

#The GUI is in charge of screen effects like transitions
# or screen flash

enum TransitionType {FADEOUT,FADEIN,DROP,RISE}

onready var curtain = get_node("Curtain")

func _ready():
	pass 


func Transition(type=TransitionType.FADEOUT):
	match(type):
		TransitionType.FADEOUT:
			curtain.FadeOut()
		TransitionType.DROP:
			curtain.Drop()
		TransitionType.RISE:
			curtain.Rise()

