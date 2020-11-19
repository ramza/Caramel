extends "BasicView.gd"

enum EquipState {OPTIONS,EQUIP_SELECT,ITEM_SELECT}

var equip_state = EquipState.OPTIONS

var itemClass = preload("res://Scenes/Items/Item.tscn")
var item

var itemLbl = preload("res://Scenes/HUD/ItemLabel.tscn")

onready var portrait = get_node("EquipMenu/HeroPortrait")
onready var equipInfoLbl = get_node("EquipMenu/EquipInfoLbl")

onready var statsNameLbl = get_node("HeroStats/StatsNameLbl")
onready var statsLbl = get_node("HeroStats/StatsLbl")

onready var equipOptionsLbl = get_node("EquipHeader/EquipActionLbl")
onready var removeOptionsLbl = get_node("EquipHeader/RemoveActionLbl")
onready var sortOptionsLbl = get_node("EquipHeader/SortActionLbl")

onready var equipItemsContainer = get_node("ScrollContainer/EquipItemsContainer")
var hero_view
var hero_id = 0


var selected_equipment_type

onready var cursor = get_node("Cursor")
var item_database
var player_inventory
var cursor_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	item = itemClass.instance()
	selected_equipment_type = item.ItemType.WEAPON
	
	player_inventory = GameManager.inventory
	item_database = GameManager.item_database
	hero_view = get_parent().get_node("HeroView")
	DisplayHeroEquipment(0)

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
	
	var statNames = "Strength: \nDexterity: \nVitality: \nIntelligence: \nSpirit: \nMagic: \n"
	statsNameLbl.text = statNames
	
	var stats = ""
	
	stats += str(hero.strength) + "\n"
	stats += str(hero.dexterity) + "\n"
	stats += str(hero.vitality) + "\n"
	stats += str(hero.intelligence) + "\n"
	stats += str(hero.spirit) + "\n"
	stats += str(hero.charm) + "\n"
	
	statsLbl.text = stats
	
func _process(delta):
	# close the hero view
	if active and Input.is_action_just_pressed("ui_cancel"):
		hero_view.Activate()
		hero_view.show()
		ChangeState(EquipState.OPTIONS)
		active=false
		self.hide()
		
	if active:
		match(equip_state):
			EquipState.OPTIONS:
				Options(delta)
			EquipState.EQUIP_SELECT:
				EquipSelect(delta)
				
func ChangeState(new_state):
	equip_state = new_state
	cursor_index = 0
				
func Options(delta):
	if Input.is_action_just_pressed("move_right"):
		cursor_index += 1
		if cursor_index > 2:
			cursor_index=2
	if Input.is_action_just_pressed("move_left"):
		cursor_index-=1
		if cursor_index<0:
			cursor_index=0
		
	if Input.is_action_just_pressed("accept"):
		ChangeState(EquipState.EQUIP_SELECT)
		return
	
	match(cursor_index):
		0:
			selected_equipment_type=item.ItemType.WEAPON
			cursor.global_position = equipOptionsLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
		1:
			selected_equipment_type=item.ItemType.ARMOR
			cursor.global_position = removeOptionsLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
		2:
			selected_equipment_type=item.ItemType.RING
			cursor.global_position = sortOptionsLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
func EquipSelect(delta):
	if Input.is_action_just_pressed("move_up"):
		cursor_index-=1
		if cursor_index<0:
			cursor_index=0
	if Input.is_action_just_pressed("move_down"):
		cursor_index+=1
		if cursor_index > 2:
			cursor_index = 2
		
	if Input.is_action_just_pressed("accept"):
		ChangeState(EquipState.ITEM_SELECT)
		return

	cursor.global_position = equipInfoLbl.rect_global_position + Vector2.LEFT*14 + (Vector2.DOWN*7 + Vector2.DOWN*14*cursor_index)
	
	
func ItemSelect(delta):
	if Input.is_action_just_pressed("move_up"):
		cursor_index-=1
		if cursor_index<0:
			cursor_index=0
	if Input.is_action_just_pressed("move_down"):
		cursor_index+=1
		if cursor_index > 2:
			cursor_index = 2
			
func FindEquipableItems():
	var equip_items = []
	
	for i in player_inventory.items:
		if i.ItemType == selected_equipment_type:
			equip_items.append(i)
			

		


