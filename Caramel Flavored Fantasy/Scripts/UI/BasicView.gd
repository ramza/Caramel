# BASIC VIEW
extends Panel

# An abstract class to handle the varius player menu states.

var active = false

var timer

func _ready():
	
	timer = get_node("InputDelay")
	timer.connect("timeout",self,"OnTimerTimeout")

	
func Activate():
	#start the timer so that the player doesn't immediately back out of the menu
	timer.start()
	self.show()
	
func Deactivate():
	self.hide()
	active = false
	
	
func OnTimerTimeout():
	active = true
	timer.stop()
	

