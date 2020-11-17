extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spawn_point = "Main"
export var destination = "WorldMap"
var GUI
onready var timer = get_node("Timer")
var wait_time = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	GUI = get_tree().get_nodes_in_group("GUI")[0]
	timer.connect("timeout",self,"OnTimerTimeout")
	connect("body_entered",self,"OnAreaBodyEntered")
	timer.wait_time = wait_time
	pass # Replace with function body.
	
func OnTimerTimeout():
	timer.stop()
	GameManager.spawn_point = spawn_point
	get_tree().change_scene("res://Scenes/Maps/"+destination+".tscn")


func OnAreaBodyEntered(body):
	if body.is_in_group("Player"):
		body.Freeze()
		timer.start()
		GUI.Transition()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
