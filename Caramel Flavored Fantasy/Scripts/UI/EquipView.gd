extends "BasicView.gd"

enum EquipState {OPTIONS,EQUIP_SELECT,ITEM_SELECT}

var equip_state = EquipState.OPTIONS

var itemClass = preload("res://Scenes/Items/Item.tscn")
var item

var itemLbl = preload("res://Scenes/HUD/ItemLabel.tscn")
onready var equipDescriptionLbl = get_node("EquipDescription/EquipDescriptionLbl")
onready var portrait = get_node("EquipMenu/HeroPortrait")
onready var equipInfoLbl = get_node("EquipMenu/EquipInfoLbl")

onready var statsNameLbl = get_node("HeroStats/StatsNameLbl")
onready var statsLbl = get_node("HeroStats/StatsLbl")

onready var equipOptionsLbl = get_node("EquipHeader/EquipActionLbl")
onready var removeActionLbl = get_node("EquipHeader/RemoveActionLbl")
onready var equipItemsContainer = get_node("ScrollContainer/EquipItemsContainer")
var hero_view
var hero_id = 0

var ui_items = []
var selected_equipment_type

onready var cursor = get_node("Cursor")
var item_database
var player_inventory
var cursor_index = 0
var equip_type_index = 0
var max_display_items = 10

var equip_items

enum Actions {EQUIP, REMOVE}
var action = Actions.EQUIP

# Called when the node enters the scene tree for the first time.
func _ready():
	item = itemClass.instance()
	selected_equipment_type = item.ItemType.WEAPON
	cursor.global_position = equipOptionsLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
	player_inventory = GameManager.inventory
	item_database = GameManager.item_database
	hero_view = get_parent().get_node("HeroView")
	DisplayHeroEquipment(hero_id)
	
	equipDescriptionLbl.text = ""
	
	for i in range(max_display_items):
		var ui_item = itemLbl.instance()
		equipItemsContainer.add_child(ui_item)
		ui_items.append(ui_item)
		ui_item.hide()
	

func DisplayHeroEquipment(id):
	var hero = GameManager.hero_party.heroes[id]
	
	var equip_txt = ""
	var weapon = item_database.GetItemByID(hero.weapon_id)
	equip_txt += "Weapon: " + weapon.item_name + "\n"
	
	var armor = item_database.GetItemByID(hero.armor_id)
	equip_txt += "Armor: " + armor.item_name + "\n"
	
	var ring = item_database.GetItemByID(hero.ring_id)
	equip_txt += "Ring: " + ring.item_name + "\n"
	
	equipInfoLbl.text = equip_txt
	
	var statNames = "Strength: \nDexterity: \nVitality: \nIntelligence: \nSpirit: \nMagic: \nAttack: \nDefense: \nMagic Attack: \nMagic Defense: \n"
	statsNameLbl.text = statNames
	
	var stats = ""
	
	stats += str(hero.strength + ring.attributes["strength_bonus"]) + "\n"
	stats += str(hero.dexterity + ring.attributes["dexterity_bonus"]) + "\n"
	stats += str(hero.vitality + ring.attributes["vitality_bonus"]) + "\n"
	stats += str(hero.intelligence + ring.attributes["intelligence_bonus"]) + "\n"
	stats += str(hero.spirit + ring.attributes["spirit_bonus"]) + "\n"
	stats += str(hero.charm + ring.attributes["charm_bonus"]) +"\n"
	stats += str(hero.strength-10) + " + [color=#03fc94]" + str(weapon.attributes["damage_bonus"]) + "[/color] + [color=#03fc94]" + str(ring.attributes["strength_bonus"]) + "[/color]\n"
	stats += str(10 + armor.attributes["armor_bonus"] + hero.dexterity + ring.attributes["dexterity_bonus"]-10) + "\n"
	stats += str((hero.intelligence-10)/2 + hero.magic + ring.attributes["magic_bonus"]) + "\n"
	stats += str((hero.intelligence-10)/2 + hero.magic) + str(ring.attributes["magic_bonus"]) + "\n"
	
	statsLbl.bbcode_text = stats
	
func _process(delta):
	# close the hero view
	if active:
		match(equip_state):
			EquipState.OPTIONS:
				Options(delta)
			EquipState.EQUIP_SELECT:
				EquipSelect(delta)
			EquipState.ITEM_SELECT:
				ItemSelect(delta)
				
func ChangeState(new_state):
	equip_state = new_state
	cursor_index = 0
				
func Options(delta):
	
	if active and Input.is_action_just_pressed("ui_cancel"):
		hero_view.Activate()
		hero_view.show()
		active=false
		self.hide()
		
	if Input.is_action_just_pressed("move_left"):
		cursor_index-=1
		if cursor_index<0:
			cursor_index=0
			
	elif Input.is_action_just_pressed("move_right"):
		cursor_index+=1
		if cursor_index>1:
			cursor_index=1
			
	match(cursor_index):
		0:
			action = Actions.EQUIP
			cursor.global_position = equipOptionsLbl.rect_global_position +Vector2.LEFT*14 + Vector2.DOWN*7
		1:
			action = Actions.REMOVE
			cursor.global_position = removeActionLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
		
	if Input.is_action_just_pressed("accept"):
		ChangeState(EquipState.EQUIP_SELECT)
		cursor_index=0
		return
		
func EquipSelect(delta):
	if active and Input.is_action_just_pressed("ui_cancel"):
		ChangeState(EquipState.OPTIONS)
		equip_type_index = 0
		return
	
	if Input.is_action_just_pressed("move_up"):
		equip_type_index-=1
		if equip_type_index<0:
			equip_type_index=0
	elif Input.is_action_just_pressed("move_down"):
		equip_type_index+=1
		if equip_type_index > 2:
			equip_type_index = 2
			
	match(equip_type_index):
		0:
			selected_equipment_type = item.ItemType.WEAPON
		1:
			selected_equipment_type = item.ItemType.ARMOR
		2:
			selected_equipment_type = item.ItemType.RING
			
	if Input.is_action_just_pressed("accept"):
		if action == Actions.EQUIP:
			FindEquipableItems()
			if len(equip_items) > 0:
				ChangeState(EquipState.ITEM_SELECT)
		else:
			RemoveItem()
		return

	cursor.global_position = equipInfoLbl.rect_global_position + Vector2.LEFT*14 + (Vector2.DOWN*7 + Vector2.DOWN*14*equip_type_index)
	
func RemoveItem():
	match(selected_equipment_type):
		item.ItemType.WEAPON:
			GameManager.hero_party.heroes[hero_id].weapon_id = 99
		item.ItemType.ARMOR:
			GameManager.hero_party.heroes[hero_id].armor_id = 99
		item.ItemType.RING:
			GameManager.hero_party.heroes[hero_id].ring_id = 99
		
	DisplayHeroEquipment(hero_id)
	
func ItemSelect(delta):
	if active and Input.is_action_just_pressed("ui_cancel"):
		ChangeState(EquipState.EQUIP_SELECT)
		ClearEquipItems()
		return
	
	if Input.is_action_just_pressed("move_up"):
		cursor_index-=1
		if cursor_index<0:
			cursor_index=0
	elif Input.is_action_just_pressed("move_down"):
		cursor_index+=1
		if cursor_index > len(equip_items)-1:
			cursor_index = len(equip_items)-1
			
	cursor.global_position = ui_items[cursor_index].rect_global_position + Vector2.LEFT*14 + (Vector2.DOWN*7)
	equipDescriptionLbl.text = equip_items[cursor_index].description

	if Input.is_action_just_pressed("accept"):
		EquipItem()
		
func EquipItem():
	match(selected_equipment_type):
		item.ItemType.WEAPON:
			GameManager.hero_party.heroes[hero_id].weapon_id = equip_items[cursor_index].id
		item.ItemType.ARMOR:
			GameManager.hero_party.heroes[hero_id].armor_id = equip_items[cursor_index].id
		item.ItemType.RING:
			GameManager.hero_party.heroes[hero_id].ring_id = equip_items[cursor_index].id
		
	DisplayHeroEquipment(hero_id)
	ClearEquipItems()
	ChangeState(EquipState.EQUIP_SELECT)
		
func ClearEquipItems():
	for i in range(max_display_items):
		ui_items[i].text = ""
		ui_items[i].hide()
		
	equipDescriptionLbl.text = ""
			
func FindEquipableItems():
	equip_items = []
	cursor_index=0
	var j = 0
	for key in player_inventory.items.keys():
		var i = item_database.GetItemByID(key)
		if i.item_type == selected_equipment_type:
			var total_e = 0
			#print(i.item_name)
			match(selected_equipment_type):
				item.ItemType.WEAPON:
					for h in GameManager.hero_party.heroes:
						if h.weapon_id == i.id:
							total_e += 1
				item.ItemType.ARMOR:
					for h in GameManager.hero_party.heroes:
						if h.armor_id == i.id:
							total_e += 1
				item.ItemType.RING:
					for h in GameManager.hero_party.heroes:
						if h.ring_id == i.id:
							total_e += 1
			
			if total_e >= player_inventory.items[i.id]:
				pass
			else:
				equip_items.append(i)
				ui_items[j].text = i.item_name + " x " + str(player_inventory.items[i.id]-total_e)
				ui_items[j].show()
				j+=1
