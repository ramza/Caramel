# ACTION PANEL
extends Panel


enum ActionType {FIGHT,MAGIC,ITEM,RUN}

var action_type = ActionType.FIGHT

onready var fightLbl = get_node("FightLbl")
onready var magicLbl = get_node("MagicLbl")
onready var itemLbl = get_node("ItemLbl")
onready var runLbl = get_node("RunLbl")
onready var nameLbl = get_node("HeroNameLbl")
onready var cursor=get_node("Cursor")

var battle_manager

var action_items = []

onready var enemy_select = get_parent().get_node("EnemySelector")

var active = false

var cursor_index = 0
var timer = 0
var input_delay = 0.3

var hero_name

# Called when the node enters the scene tree for the first time.
func _ready():
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]
	
	action_items.append(fightLbl)
	action_items.append(magicLbl)
	action_items.append(itemLbl)
	action_items.append(runLbl)
				
	pass # Replace with function body.

func Activate(hero_name):
	
	nameLbl.text = hero_name
	self.hero_name = hero_name
	timer = 0
	active = true
	self.show()
	
func FindHeroID(name):
	for h in battle_manager.heroes:
		if h.hero_name == name:
			return h

func Deactivate():
	active = false
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if active and timer > input_delay:
		if Input.is_action_just_pressed("move_down"):
			cursor_index += 1
			if cursor_index > 3:
				cursor_index=3
		elif Input.is_action_just_pressed("move_up"):
			cursor_index-= 1
			if cursor_index < 0:
				cursor_index=0
	
		cursor.global_position = action_items[cursor_index].rect_global_position + Vector2.LEFT*10 + Vector2.DOWN*7
	
		if Input.is_action_just_pressed("accept"):
			match(cursor_index):
				0:
					action_type=ActionType.FIGHT
					Fight()
				1:
					action_type=ActionType.FIGHT
					Magic()
				
func Magic():
	pass
	
func Fight():
	enemy_select.Activate(FindHeroID(hero_name),action_type)
	Deactivate()
	
