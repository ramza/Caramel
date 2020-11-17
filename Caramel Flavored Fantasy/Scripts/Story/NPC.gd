extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var story
var player
var player_present = false

var talking = false

onready var anim = get_node("AnimationPlayer")

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
	
func FacePlayer():
	var distanceX = player.position.x - position.x
	var distanceY = player.position.y - position.y
	
	if abs(distanceX) > abs(distanceY):
		#vertical
		if distanceX > 0:
			anim.play("idle_right")
		else:
			anim.play("idle_left")
	else:
		#horizontal
		if distanceY > 0:
			anim.play("idle_down")
		else:
			anim.play("idle_up")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not talking and player_present and Input.is_action_just_pressed("accept"):
		talking = true
		FacePlayer()
		story.StartStory(self)
		player.Freeze()
