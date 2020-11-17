#STORY LAYER CONTROL
extends CanvasLayer


var timer = 0.0
var input_delay = 2.0

var tick       = 0.0
var text_delay = 0.1

var inDialogue=false
var story_control
var dialogues = []
var dialogue_index = 0
onready var cursor_anim = get_node("StoryPanel/TextureRect/Cursor/AnimationPlayer")
var current_msg = ""
var current_text = ""
var text_index = 0
var msg_complete = false
onready var story_text = get_node("StoryPanel/TextureRect/RichTextLabel")
onready var story_panel = get_node("StoryPanel")
# Called when the node enters the scene tree for the first time.
func _ready():
	story_panel.hide()
	story_text.text=""
	cursor_anim.play("hide")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inDialogue:
		
		tick += delta
		if not msg_complete and tick > text_delay:
			tick = 0
			current_text += current_msg[text_index] + " "
			text_index+=1
			if text_index > current_msg.size()-1:
				msg_complete = true
			
				
			story_text.text = current_text
		
		timer += delta
		
		if timer > input_delay:
			cursor_anim.play("blink")
			if Input.is_action_just_pressed("accept"):
				timer = 0
				cursor_anim.play("hide")
				dialogue_index+=1
				msg_complete = false
				current_text=""
				tick = 0
				text_index=0
				if dialogue_index >= dialogues.size():
					story_control.EndDialogue()
					story_panel.hide()
					inDialogue=false
					story_text.text = ""

					return 
					
				current_msg = dialogues[dialogue_index].split(" ")

func StartStory(story_control):
	story_text.text = ""
	cursor_anim.play("hide")
	dialogue_index = 0
	self.story_control = story_control
	timer = 0
	msg_complete = false
	self.dialogues = story_control.dialogues
	text_index=0
	story_panel.show()
	current_msg = dialogues[dialogue_index].split(" ")
	
	inDialogue = true
	
