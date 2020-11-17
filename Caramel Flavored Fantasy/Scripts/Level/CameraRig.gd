extends KinematicBody2D

const SCREEN_WIDTH = 384
const SCREEN_HEIGHT = 216
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player

export var min_x = 0
export var max_x = 0
export var min_y = 0
export var max_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	position = player.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = player.position

	if global_position.x < min_x + SCREEN_WIDTH/2:
		global_position.x = min_x + SCREEN_WIDTH/2
	elif global_position.x > max_x - SCREEN_WIDTH/2:
		global_position.x = max_x - SCREEN_WIDTH/2
		
	if global_position.y < min_y + SCREEN_HEIGHT/2:
		global_position.y = min_y + SCREEN_HEIGHT/2
	elif global_position.y > max_y - SCREEN_HEIGHT/2:
		global_position.y = max_y - SCREEN_HEIGHT/2
