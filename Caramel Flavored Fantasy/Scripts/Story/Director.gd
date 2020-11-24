# DIRECTOR
extends Node2D


onready var file = "res://Other/StoryScripts/CastleCutscene.txt"

onready var script_loader = get_node("ScriptLoader")
var actors

var file_data

var active = false

var timer = 0.0
var scene_tick = 1.0

var line_index = 0

var dialogues = []

var story_control

var gui

# Called when the node enters the scene tree for the first time.
func _ready():
	gui = get_tree().get_nodes_in_group("GUI")[0]
	story_control = get_tree().get_nodes_in_group("Story")[0]
	
	file_data = script_loader.load_file(file)
	
	#print(file_data)
	
	actors = get_tree().get_nodes_in_group("Actors")
	
	StartScene()

func StartScene():
	active = true
	
func PauseStory():
	active= false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		timer += delta
		if timer > scene_tick:
			timer = 0
			
			ReadNextLine()
			
func ContinueStory():
	active=true
	timer = 0
	
func EndDialogue():
	ContinueStory()
			
func ReadNextLine():
	
	if line_index >= len(file_data):
		print("scene finished")
		timer = 0
		active = false
		return
	
	var line = file_data[line_index]
	line_index+=1
	var words = line.split(" ")
	var actor_name = words[0]
	var action = words [1]
	
	if actor_name == "Director":
		match(action):
			"fadeout":
				gui.Transition(gui.TransitionType.FADEOUT)
				return
			"fadein":
				gui.Transition(gui.TransitionType.FADEIN)
			"screenflash":
				gui.FlashScreen(gui.EffectType.WHITEFLASH)
	
	if action == "say":
		dialogues.clear()
		var d = ""
		words.remove(1)
		words[0] = words[0].to_upper()
		words[0]+= ":"
		for word in words:
			d += word + " "
		
		dialogues.append(d)
		story_control.StartStory(self)
		PauseStory()
		
	elif action == "walk":
		for actor in actors:
			if actor.name == actor_name:
				match(words[2]):
					"up":
						actor.direction = actor.Direction.UP
					"down":
						actor.direction = actor.Direction.DOWN
					"right":
						actor.direction = actor.Direction.RIGHT
					"left":
						actor.direction = actor.Direction.LEFT
				actor.ChangeState(actor.ActorState.WALK)
				#PauseStory()
	elif action == "look":
		for actor in actors:
			if actor.name == actor_name:
				match(words[2]):
					"up":
						actor.direction = actor.Direction.UP
					"down":
						actor.direction = actor.Direction.DOWN
					"right":
						actor.direction = actor.Direction.RIGHT
					"left":
						actor.direction = actor.Direction.LEFT
				
				
	print(actor_name + " " + action)
