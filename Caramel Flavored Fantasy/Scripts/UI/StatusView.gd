# STATUS VIEW
extends "BasicView.gd"

var hero_view

# Called when the node enters the scene tree for the first time.
func _ready():
	hero_view = get_parent().get_node("HeroView")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active and Input.is_action_just_pressed("ui_cancel"):
		hero_view.Activate()
		Deactivate()

