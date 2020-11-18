# BASIC VIEW
extends Panel

# An abstract class to handle the varius player menu states.

var active = false

var timer

func _ready():
	
	timer = get_node("InputDelay")
	timer.connect("timeout",self,"OnTimerTimeout")

	
func Activate():
	timer.start()
	self.show()
	
	
func OnTimerTimeout():
	active = true
	timer.stop()
	

