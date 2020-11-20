# HERO SELECT VIEW
extends "BasicView.gd"

var heroUIs = []

var player_inventory
var item_database
var heroes
onready var itemLbl = get_node("infoPanel/ItemLbl")

var current_item
var cursor_index = 0
var hero_panels = []

var cursor_position_mod = Vector2(40,20)

onready var item_view = get_parent().get_node("ItemView")

onready var cursor = get_node("Cursor")

onready var heroPanel1 = get_node("HeroPanel1")
onready var heroPanel2 = get_node("HeroPanel2")
onready var heroPanle3 = get_node("HeroPanel3")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hero_panels.append(heroPanel1)
	hero_panels.append(heroPanel2)
	hero_panels.append(heroPanle3)
	
	heroPanel2.hide()
	heroPanle3.hide()
	
	player_inventory = GameManager.inventory
	item_database = GameManager.item_database
	heroes = GameManager.hero_party.heroes

func Setup(item_id):
	cursor.global_position = heroPanel1.rect_global_position + Vector2.LEFT * cursor_position_mod.x + Vector2.DOWN*cursor_position_mod.y
	UpdateHeroInfo()
	current_item = item_database.GetItemByID(item_id)
	UpdateItemDisplay()
	
func UpdateItemDisplay():
	
	if player_inventory.items.has(current_item.id):
		itemLbl.text = current_item.item_name + " x " + str(player_inventory.items[current_item.id])
	else:
		itemLbl.text = current_item.item_name + " x 0"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		# close the hero view
	if active and Input.is_action_just_pressed("ui_cancel"):
		item_view.Activate()
		item_view.show()
		active=false
		self.hide()
	
	if active:
		
		if Input.is_action_just_pressed("move_down"):
			cursor_index += 1
			if cursor_index > len(heroes)-1:
				cursor_index = len(heroes)-1
		elif Input.is_action_just_pressed("move_up"):
			cursor_index-=1
			if cursor_index < 0:
				cursor_index = 0
				
		cursor.global_position = hero_panels[cursor_index].rect_global_position + Vector2.LEFT*cursor_position_mod.x + Vector2.DOWN*cursor_position_mod.y
		
		if Input.is_action_just_pressed("accept"):
			if not player_inventory.items.has(current_item.id):
				return
			
			match(current_item.effect_type):
				current_item.EffectType.CURE:
					if heroes[cursor_index].curHP < heroes[cursor_index].maxHP:	
						heroes[cursor_index].curHP += current_item.attributes["hp_bonus"]
						player_inventory.RemoveItemById(current_item.id)
				current_item.EffectType.REZ:
					if heroes[cursor_index].curHP == 0:
						heroes[cursor_index].curHP += current_item.attributes["hp_bonus"]
						player_inventory.RemoveItemById(current_item.id)
				current_item.EffectType.HEAL:
					if heroes[cursor_index].status == "Poison":
						heroes[cursor_index].status = "OK"
						player_inventory.RemoveItemById(current_item.id)
			
			player_inventory.RemoveItemById(current_item.id)
			UpdateItemDisplay()
			
			UpdateHeroInfo()
		
func UpdateHeroInfo():
	var hero_party = GameManager.hero_party
	
	var i=0
	for hero in hero_party.heroes:
		hero_panels[i].get_node("NameLbl").text = hero.hero_name
		hero_panels[i].get_node("HPLbl").text = "HP: " + str(hero.curHP) + "/" + str(hero.maxHP)
		hero_panels[i].get_node("MPLbl").text = "MP: " + str(hero.curMP) + "/" + str(hero.maxMP)
		hero_panels[i].get_node("LevelLbl").text = "Lv: " + str(hero.level)
		hero_panels[i].get_node("StatusLbl").text = "Status: " + hero.status
		PaintPortrait(hero.hero_name,hero_panels[i].get_node("Sprite"))
		hero_panels[i].show()
		i+=1

func PaintPortrait(name, sprite):
	match(name):
		"Sid":
			sprite.region_rect = Rect2(0,0,40,40)
		"Star":
			sprite.region_rect = Rect2(40,0,40,40)
		"Cid":
			sprite.region_rect = Rect2(80,0,40,40)

