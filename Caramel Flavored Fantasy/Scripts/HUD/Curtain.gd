# CURTAIN
extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	FadeIn()
	

func FadeOut():
	anim.play("fade_out")
	
func FadeIn():
	anim.play("fade_in")

func Drop():
	anim.play("drop")
	
func Rise():
	anim.play("rise")

