extends Node


var item_database
var inventory = {}

var spawn_point = "Main"
# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = get_node("ItemDatabase")
	item_database.BuildDatabase()

