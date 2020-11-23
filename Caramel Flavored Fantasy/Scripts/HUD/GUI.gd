# GUI
extends CanvasLayer

#The GUI is in charge of screen effects like transitions
# or screen flash

enum TransitionType {FADEOUT,FADEIN,DROP,RISE}

enum EffectType {WHITEFLASH,REDFLASH}

var effect_type = EffectType.WHITEFLASH

var flash_count = 0
var flash_max = 5

onready var curtain = get_node("Curtain")
onready var whiteScreen = get_node("WhiteScreen")


func _ready():
	whiteScreen.hide()
	pass 
	

func FlashScreen():
	pass


func Transition(type=TransitionType.FADEOUT):
	match(type):
		TransitionType.FADEOUT:
			curtain.FadeOut()
		TransitionType.DROP:
			curtain.Drop()
		TransitionType.RISE:
			curtain.Rise()



func _on_FlashTimer_timeout():
	pass # Replace with function body.
