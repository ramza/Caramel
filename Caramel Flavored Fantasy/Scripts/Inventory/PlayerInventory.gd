# PLAYER INVENTORY
extends Node


onready var item_database = GameManager.get_node("ItemDatabase")

var items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database.BuildDatabase()
	
	AddItemByID(0,1)
	AddItemByID(0)
	AddItemByID(1)
	AddItemByID(1)
	AddItemByID(2)
	AddItemByID(3)
	AddItemByID(4)
	AddItemByID(5)
	AddItemByID(6)
	
	for key in items.keys():
		var item = item_database.GetItemByID(key)
		print(item.item_name, items[key])
	
	
func GetItems():
	return items
	
func AddItemByID(id,amount=1):
	var item = item_database.GetItemByID(id)
	
	if items.has(id):
		items[id] += amount
		return
	
	else:
		items[id] = amount
	
