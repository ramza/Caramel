extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false
var positions = []
var cursor_index = 0
onready var cursor = get_node("HeroOptions/Cursor")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	positions = $HeroOptions.get_children()
	positions.remove(len(positions)-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		return
	
	if Input.is_action_just_pressed("move_down"):
		cursor_index+=1
		if cursor_index > 7:
			cursor_index= 7
	elif Input.is_action_just_pressed("move_up"):
		cursor_index-=1
		if cursor_index<0:
			 cursor_index = 0
			
	cursor.position = positions[cursor_index].rect_position + (Vector2.RIGHT * -10)+(Vector2.DOWN*7)
	
