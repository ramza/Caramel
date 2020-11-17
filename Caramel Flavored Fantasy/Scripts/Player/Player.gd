extends KinematicBody2D

enum DIRECTION {UP,DOWN,LEFT,RIGHT}

var direction = DIRECTION.DOWN
# This is a demo showing how KinematicBody2D
# move_and_slide works.
onready var anim = get_node("AnimationPlayer")
# Member variables
const MOTION_SPEED = 60 # Pixels/second

var frozen = false

func Freeze():
	frozen = true

func Release():
	frozen = false
	
func _physics_process(_delta):

	
	var motion = Vector2()
	
	if frozen:
		HandleAnimation(motion)
		return
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
		direction = DIRECTION.UP
	if Input.is_action_pressed("move_down"):
		motion += Vector2(0, 1)
		direction = DIRECTION.DOWN
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
		direction = DIRECTION.LEFT
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
		direction = DIRECTION.RIGHT
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	HandleAnimation(motion)

				
func HandleAnimation(motion):
	if motion != Vector2.ZERO:
		match(direction):
			DIRECTION.UP:
				anim.play("walk_up")
			DIRECTION.DOWN:
				anim.play("walk_down")
			DIRECTION.LEFT:
				anim.play("walk_left")
			DIRECTION.RIGHT:
				anim.play("walk_right")
	else:
		match(direction):
			DIRECTION.UP:
				anim.play("idle_up")
			DIRECTION.DOWN:
				anim.play("idle_down")
			DIRECTION.LEFT:
				anim.play("idle_left")
			DIRECTION.RIGHT:
				anim.play("idle_right")
