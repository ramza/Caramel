# INVENTORY VIEW
extends Panel

var inventory_items = []
onready var description = get_node("ItemDescription/DescriptionLbl")
onready var items_container = get_node("ScrollContainer/ItemsContainer")
onready var cursor = get_node("Cursor")
var hero_select

var item_label = preload("res://Scenes/HUD/ItemLabel.tscn")

var item_labels = []

var item_database
var player_inventory
var timer
var active = false
var hero_view
var total_items
var ui_items = []

var cursor_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hero_view = get_parent().get_node("HeroView")
	hero_select = get_parent().get_node("HeroSelectView")
	timer = get_node("InputDelay")
	
	item_database = GameManager.GetItemDataBase()
	player_inventory = GameManager.inventory
	
	for i in range(10):
		var item = item_label.instance()
		items_container.add_child(item)
		item_labels.append(item)
		item.hide()
	
	var i = 0
	
	var items = player_inventory.GetItems()
	
	for key in player_inventory.items.keys():
		var item = GameManager.item_database.GetItemByID(key)
		item_labels[i].text = item.item_name + " x" + str(items[key])
		item_labels[i].show()
		i+=1
		ui_items.append(item)
		
	total_items = i
	timer.connect("timeout",self,"OnTimerTimeout")
	
	PositionCursor()
	DescribeItem()
	
func OnTimerTimeout():
	active = true
	timer.stop()

func Activate():
	cursor_index=0
	PositionCursor()
	timer.start()
	self.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# close the hero view
	if active and Input.is_action_just_pressed("ui_cancel"):
		hero_view.Activate()
		hero_view.show()
		active=false
		self.hide()
		
	if active:
		if Input.is_action_just_pressed("move_down"):
			cursor_index += 1
			if cursor_index > total_items-1:
				cursor_index=total_items-1
		elif Input.is_action_just_pressed("move_up"):
			cursor_index -= 1
			if cursor_index < 0:
				cursor_index = 0
				
		PositionCursor()
		DescribeItem()
				

func PositionCursor():
	cursor.global_position = items_container.rect_global_position + item_labels[cursor_index].rect_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
		
func DescribeItem():
	description.text = ui_items[cursor_index].description
		
		
