# SIGN
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var story
var player
var player_present = false

var talking = false

export var dialogues = [
	"This is the first line of dialogue. It's just some filler text.",
	"Even more dialouge will make the story detailed and immersive.",
]


onready var activation_area = get_node("ActivationArea")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	story = get_tree().get_nodes_in_group("Story")[0]
	player = get_tree().get_nodes_in_group("Player")[0]
	activation_area.connect("body_entered",self,"OnActivationAreaBodyEntered")
	activation_area.connect("body_exited",self,"OnActivationAreaBodyExited")
	
func OnActivationAreaBodyEntered(body):
	if body.is_in_group("Player"):
		player_present=true
	
	
func OnActivationAreaBodyExited(body):
	if body.is_in_group("Player"):
		player_present=false
	
		if talking:
			talking = false
			
		
func EndDialogue():
	player.Release()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not talking and player_present and Input.is_action_just_pressed("accept"):
		talking = true
	
		story.StartStory(self)
		player.Freeze()
