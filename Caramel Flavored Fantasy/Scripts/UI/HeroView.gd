# HERO VIEW
extends "BasicView.gd"

var positions = []
var cursor_index = 0
var item_view
var equip_view

onready var cursor = get_node("HeroOptions/Cursor")

onready var heroPanel1 = get_node("HeroPanel")
onready var heroPanel2 = get_node("HeroPanel2")
onready var heroPanle3 = get_node("HeroPanel3")

var hero_panels = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hero_panels.append(heroPanel1)
	hero_panels.append(heroPanel2)
	hero_panels.append(heroPanle3)
	
	item_view = get_parent().get_node("ItemView")
	equip_view = get_parent().get_node("EquipView")
	
	positions = $HeroOptions.get_children()
	positions.remove(len(positions)-1)
	
	heroPanel2.hide()
	heroPanle3.hide()
	
	UpdateHeroInfo()
	PositionCursor()

func Activate():
	#start the timer so that the player doesn't immediately back out of the menu
	timer.start()
	UpdateHeroInfo()
	self.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		return
	
	if Input.is_action_just_pressed("move_down"):
		cursor_index+=1
		if cursor_index > 7:
			cursor_index= 7
	elif Input.is_action_just_pressed("move_up"):
		cursor_index-=1
		if cursor_index<0:
			 cursor_index = 0
			
	PositionCursor()
	
	if Input.is_action_just_pressed("accept"):
		if cursor_index == 0:
			item_view.Activate()
			active=false
			self.hide()
		elif cursor_index == 1:
			equip_view.Activate()
			active = false
			self.hide()
			
	elif Input.is_action_just_pressed("ui_cancel"):
		#print("quit hero view menu")
		get_parent().ClosePlayerMenu()
		active=false
		self.hide()
		cursor_index=0
		
func PositionCursor():
	cursor.position = positions[cursor_index].rect_position + (Vector2.RIGHT * -10)+(Vector2.DOWN*7)
	
func UpdateHeroInfo():
	var hero_party = GameManager.hero_party
	
	var i=0
	for hero in hero_party.heroes:
		hero_panels[i].get_node("NameLbl").text = hero.hero_name
		hero_panels[i].get_node("HPLbl").text = "HP: " + str(hero.curHP) + "/" + str(hero.maxHP)
		hero_panels[i].get_node("MPLbl").text = "MP: " + str(hero.curMP) + "/" + str(hero.maxMP)
		hero_panels[i].get_node("LevelLbl").text = "Lv: " + str(hero.level)
		var status_text = "OK"
		match(hero.status):
			hero.HeroStatus.OK:
				pass
			hero.HeroStatus.POISON:
				status_text = "Poison"
		
		hero_panels[i].get_node("StatusLbl").text = "Status: " + status_text
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
