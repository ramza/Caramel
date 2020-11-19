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
	
	var silver_ring = item.instance()
	silver_ring.item_name = "Silver Ring"
	silver_ring.id = 7
	silver_ring.item_type = silver_ring.ItemType.RING
	silver_ring.item_class = silver_ring.ItemClass.MAGIC
	silver_ring.description = "Adds '+1' to dexterity."
	silver_ring.attributes = {
		"value":100,
		"dexterity_bonus":1,
	}
	items.append(silver_ring)
	
	var gold_ring = item.instance()
	gold_ring.item_name = "Gold Ring"
	gold_ring.id = 8
	gold_ring.item_type = gold_ring.ItemType.RING
	gold_ring.item_class = gold_ring.ItemClass.MAGIC
	gold_ring.description = "Adds '+1' to strength."
	gold_ring.attributes = {
		"value":100,
		"strength_bonus":1,
	}
	items.append(gold_ring)
	
	var ruby_ring = item.instance()
	ruby_ring.item_name = "Ruby Ring"
	ruby_ring.id = 9
	ruby_ring.item_type = ruby_ring.ItemType.RING
	ruby_ring.item_class = ruby_ring.ItemClass.MAGIC
	ruby_ring.description = "Adds '+1' to vitality."
	ruby_ring.attributes = {
		"value":100,
		"vitality_bonus":1,
	}
	items.append(ruby_ring)
	
	var emerald_ring = item.instance()
	emerald_ring.item_name = "Emerald Ring"
	emerald_ring.id = 10
	emerald_ring.item_type = emerald_ring.ItemType.RING
	emerald_ring.item_class = emerald_ring.ItemClass.MAGIC
	emerald_ring.description = "Adds '+1' to Intelligence."
	emerald_ring.attributes = {
		"value":100,
		"intelligence_bonus":1,
	}
	items.append(emerald_ring)
	
		
	var iron_dagger = item.instance()
	iron_dagger.item_name = "Iron Dagger"
	iron_dagger.id = 11
	iron_dagger.item_type = iron_dagger.ItemType.WEAPON
	iron_dagger.item_class = iron_dagger.ItemClass.SWORD
	iron_dagger.description = "A basic weapon for fighting."
	iron_dagger.attributes = {
		"value":6,
		"damage_bonus":3,
	}
	items.append(iron_dagger)
	
	var gold_armor = item.instance()
	gold_armor.item_name = "Gold Armor"
	gold_armor.id = 12
	gold_armor.item_type = gold_armor.ItemType.ARMOR
	gold_armor.item_class = gold_armor.ItemClass.HEAVY
	gold_armor.description = "Offers superior projection."
	gold_armor.attributes = {
		"value":160,
		"damage_bonus":6,
	}
	items.append(gold_armor)
	
	var ring_of_health = item.instance()
	ring_of_health.item_name = "Ring of Health"
	ring_of_health.id = 13
	ring_of_health.item_type = ring_of_health.ItemType.RING
	ring_of_health.item_class = ring_of_health.ItemClass.MAGIC
	ring_of_health.description = "Grants the wearer extra health."
	ring_of_health.attributes = {
		"value":300,
		"hp_bonus":10,
	}
	items.append(ring_of_health)
	
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


