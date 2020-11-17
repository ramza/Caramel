#HUD
extends CanvasLayer

#The HUD is in charge of the player menu system

onready var hero_view = get_node("HeroView")

var paused = false
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	hero_view.hide()
	pass # Replace with function body.

func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		paused=not paused
		
		if paused:
			hero_view.show()
			hero_view.active=true
			player.Freeze()
		else:
			hero_view.hide()
			hero_view.active=false
			player.Release()
		
