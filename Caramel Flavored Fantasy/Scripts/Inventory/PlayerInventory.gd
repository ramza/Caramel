# PLAYER INVENTORY
extends Node


onready var item_database = GameManager.get_node("ItemDatabase")

var items = {}
var item_key_order = []

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database.BuildDatabase()
	
	AddItemByID(0,1)
	AddItemByID(0)
	AddItemByID(1,3)
	AddItemByID(2,2)
	AddItemByID(3)
	AddItemByID(4)
	AddItemByID(5)
	AddItemByID(6)
	AddItemByID(7)
	AddItemByID(8)
	AddItemByID(9)
	AddItemByID(10)
	AddItemByID(11)
	AddItemByID(12)
	AddItemByID(13)
	
	for key in items.keys():
		var item = item_database.GetItemByID(key)
		#print(item.item_name, items[key])
	
	
func GetItems():
	return items
	
func AddItemByID(id,amount=1):
	var item = item_database.GetItemByID(id)
	
	if items.has(id):
		items[id] += amount
		return
	
	else:
		items[id] = amount
		item_key_order.append(id)
		
func RemoveItemById(id, amount=1):
	var item = item_database.GetItemByID(id)
	
	items[id] -= amount
	
	if items[id] < 1:
		print("erase item")
		items.erase(id)
	
