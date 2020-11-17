extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var item_database = get_node("ItemDatabase")

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database.BuildDatabase()
	
	items.append(item_database.GetItemByID(0))
	items.append(item_database.GetItemByName("Potion of Healing"))
	items.append(item_database.GetItemByID(1))

	for i in range(len(items)):
		print(items[i].item_name)
	
