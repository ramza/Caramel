# STORY ACTOR
extends KinematicBody2D

enum ActorState {IDLE, WALK, TAUNT}

var state = ActorState.IDLE
enum Direction {UP,RIGHT,DOWN,LEFT}

export var direction = Direction.DOWN

var speed = 2000
var velocity = Vector2.ZERO

var timer=0.0
var walk_time = 1
var taunt_time = 1

onready var anim = get_node("AnimationPlayer")
onready var sprite= get_node("Sprite")


func _process(delta):
	
	match(state):
		ActorState.IDLE:
			Idle(delta)
		ActorState.WALK:
			Walk(delta)
		ActorState.TAUNT:
			Taunt(delta)
			
func Taunt(delta):
	timer += delta
	if timer > taunt_time:
		ChangeState(ActorState.IDLE)
			
func Idle(delta):
	match(direction):
		Direction.UP:
			anim.play("idle_up")
		Direction.DOWN:
			anim.play("idle_down")
		Direction.LEFT:
			anim.play("idle_left")
		Direction.RIGHT:
			anim.play("idle_right")
	
func ChangeState(new_state):
	state =new_state
	timer = 0
	
func Walk(delta):
	timer += delta
	if timer > walk_time:
		ChangeState(ActorState.IDLE)
	
	var force = Vector2.ZERO
	match(direction):
		Direction.UP:
			anim.play("walk_up")
			force = Vector2.UP
		Direction.DOWN:
			anim.play("walk_down")
			force = Vector2.DOWN
		Direction.LEFT:
			anim.play("walk_left")
			force = Vector2.LEFT
		Direction.RIGHT:
			anim.play("walk_right")
			force = Vector2.RIGHT
			
	velocity = force *speed*delta
	move_and_slide(velocity)
