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
	iron_sword.item_class = iron_sword.ItemClass.SWORD
	iron_sword.item_type = iron_sword.ItemType.WEAPON
	iron_sword.description = "An iron sword forged by a blacksmith."
	iron_sword.attributes = {
		"damage_bonus":6,
		"value":10,
	}
		
	items.append(iron_sword)
	
	var iron_armor = item.instance()
	iron_armor.item_name = "Iron Armor"
	iron_armor.id = 2
	iron_armor.item_type = iron_armor.ItemType.ARMOR
	iron_armor.item_class = iron_armor.ItemClass.HEAVY
	iron_armor.description = "Heavy armor that offers ample protection."
	iron_armor.attributes = {
		"armor_bonus":5,
		"value":50,
	}
	
	items.append(iron_armor)
	
	var healing_herb = item.instance()
	healing_herb.item_name = "Healing Herb"
	healing_herb.id = 3
	healing_herb.item_class = healing_herb.ItemClass.POTION
	healing_herb.item_type = healing_herb.ItemType.USE
	healing_herb.description = "A natural remedy to physical ailments."
	healing_herb.attributes = {
		"value":7,
		"hp_bonus":8,
	}
	
	items.append(healing_herb)
	
	var chain_mail = item.instance()
	chain_mail.item_name = "Chain Mail"
	chain_mail.id = 4
	chain_mail.item_type = chain_mail.ItemType.ARMOR
	chain_mail.item_class = chain_mail.ItemClass.LIGHT
	chain_mail.description = "A suit of finely-linked, steel chains."
	chain_mail.attributes = {
		"value":25,
		"armor_bonus":4,
	}
	
	items.append(chain_mail)
	
	var steel_sword = item.instance()
	steel_sword.item_name = "Steel Sword"
	steel_sword.id = 5
	steel_sword.item_type = steel_sword.ItemType.WEAPON
	steel_sword.item_class = steel_sword.ItemClass.SWORD
	steel_sword.description = "A well-balanced blade sharped to a deadly edge."
	steel_sword.attributes = {
		"value":25,
		"damage_bonus":10,
	}
	
	items.append(steel_sword)
	
	var revive = item.instance()
	revive.item_name = "Revive"
	revive.id = 6
	revive.item_type = revive.ItemType.USE
	revive.item_class = revive.ItemClass.POTION
	revive.description = "Use this to brink back a fallen comrade."
	revive.attributes = {
		"value":25,
		"hp_bonus":30,
	}
	
	items.append(revive)
	
	
	var empty_equipment_slot = item.instance()
	empty_equipment_slot.item_name = "Empty"
	empty_equipment_slot.id = 99
	empty_equipment_slot.item_type = empty_equipment_slot.ItemType.STORY
	empty_equipment_slot.description = "There is nothing here."
	empty_equipment_slot.attributes = {
		"value":0,
	}
	
	items.append(empty_equipment_slot)
	
func GetItemByID(id):
	for item in items:
		if item.id == id:
			return item
			
func GetItemByName(name):
	for item in items:
		if item.item_name == name:
			return item


