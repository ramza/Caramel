# NPC
extends KinematicBody2D


enum NPCState {IDLE,WALK}

var state = NPCState.IDLE

enum Direction {LEFT,RIGHT,UP,DOWN}
var direction = Direction.DOWN

var timer = 0.0

var idle_time = 2.0
var walk_time = 2.0

var speed = 10

var story
var player
var player_present = false

var velocity = Vector2.ZERO

var talking = false

export var move = false

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

func _process(delta):
	if not talking and player_present and Input.is_action_just_pressed("accept"):
		talking = true
		FacePlayer()
		story.StartStory(self)
		player.Freeze()
		
		
	elif not talking:
		match(state):
			NPCState.IDLE:
				Idle(delta)
			NPCState.WALK:
				Walk(delta)

func Idle(delta):
	timer += delta
	
	if timer > idle_time:
		ChangeState(NPCState.WALK)
	
func Walk(delta):
	timer += delta
	
func ChangeState(new_state):
	state = new_state
