extends Node


var items = []

var item = preload("res://Scenes/Items/Item.tscn")

func _ready():
	pass 


func BuildDatabase():
	
	var potion_of_healing = item.instance()
	items.append(potion_of_healing)
	
	var iron_sword = item.instance()
	iron_sword.item_name = "Iron Sword"
	iron_sword.id = 1
	iron_sword.item_type = iron_sword.ItemType.WEAPON
	iron_sword.description = "An iron sword forged by a blacksmith."
	iron_sword.attributes = {
		"damage":6,
		"value": 3,
	}
	
	items.append(iron_sword)
	
func GetItemByID(id):
	for item in items:
		if item.id == id:
			return item
			
func GetItemByName(name):
	for item in items:
		if item.item_name == name:
			return item


