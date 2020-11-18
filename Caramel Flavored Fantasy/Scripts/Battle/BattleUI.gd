# BATTLE UI
extends CanvasLayer

onready var action_panel = get_node("Container/ActionPanel")
onready var msg_panel = get_node("Container/MSGPanel")
onready var msg_text = get_node("Container/MSGPanel/RichTextLabel")


# Called when the node enters the scene tree for the first time.
func _ready():
	action_panel.hide()
	msg_text.text = "Fight!"

func TakeNextTurn():
	pass
	
	

