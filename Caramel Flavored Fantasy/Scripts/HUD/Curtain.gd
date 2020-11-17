# CURTAIN
extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("rise")
	pass # Replace with function body.


func Drop():
	anim.play("drop")

