# NPC
extends KinematicBody2D


enum NPCState {IDLE,WALK}

var state = NPCState.IDLE

enum Direction {LEFT,RIGHT,UP,DOWN}
var direction = Direction.DOWN

var steps = 0

var timer = 0.0

var idle_time = 2.0
var walk_time = 2.0

var speed = 2000

var story
var player
var player_present = false

var velocity = Vector2.ZERO

var talking = false
var ray_length = 10
export var move = false

onready var anim = get_node("AnimationPlayer")
onready var raycast = get_node("RayCast2D")

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
		
		
	elif move and not talking:
		match(state):
			NPCState.IDLE:
				Idle(delta)
			NPCState.WALK:
				Walk(delta)

func Idle(delta):

	timer += delta
	match(direction):
		Direction.UP:
			anim.play("idle_up")
		Direction.LEFT:
			anim.play("idle_left")
		Direction.RIGHT:
			anim.play("idle_right")
		Direction.DOWN:
			anim.play("idle_down")
	
	if timer > idle_time:
		if  steps == 1:
			#walk back
			match(direction):
				Direction.UP:
					direction = Direction.DOWN
					raycast.cast_to = Vector2.DOWN*ray_length
				Direction.LEFT:
					direction = Direction.RIGHT
					raycast.cast_to = Vector2.RIGHT*ray_length
				Direction.RIGHT:
					direction = Direction.LEFT
					raycast.cast_to = Vector2.LEFT*ray_length
				Direction.DOWN:
					direction = Direction.UP
					raycast.cast_to = Vector2.UP*ray_length
					
		elif steps == 0:
			ChooseNewDirection()
		elif steps == 2:
			ChooseNewDirection()
			steps = 0
			
		anim.play("idle_down")
		ChangeState(NPCState.WALK)
		
func ChooseNewDirection():
	
	var r = int(rand_range(0,3))

	match(r):
		0:
			direction = Direction.UP
			raycast.cast_to = Vector2.UP*ray_length
		1:
			direction = Direction.RIGHT
			raycast.cast_to=Vector2.RIGHT*ray_length
		2:
			direction = Direction.LEFT
			raycast.cast_to=Vector2.LEFT*ray_length
		3:
			direction = Direction.DOWN
			raycast.cast_to=Vector2.DOWN*ray_length
	
func Walk(delta):
	
	
	timer += delta
	if raycast.is_colliding() or timer > walk_time:
		ChangeState(NPCState.IDLE)
		steps += 1
		return
		
	var force = Vector2.ZERO
		
	match(direction):
		Direction.UP:
			force = Vector2.UP
			anim.play("walk_up")
		Direction.LEFT:
			force = Vector2.LEFT
			anim.play("walk_left")
		Direction.RIGHT:
			force = Vector2.RIGHT
			anim.play("walk_right")
		Direction.DOWN:
			force = Vector2.DOWN
			anim.play("walk_down")
			
	velocity= force*speed*delta
	velocity = move_and_slide(velocity)
	

func ChangeState(new_state):
	state = new_state
	timer = 0
