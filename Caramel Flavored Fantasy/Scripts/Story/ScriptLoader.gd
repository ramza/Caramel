# SCRIPT LOADER
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func load_file(file):
	var data = []
	var f = File.new()
	f.open(file, File.READ)
	var index = 1
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		line += " "
		#print(line + str(index))
		data.append(line)
		index += 1
	f.close()
	return data
