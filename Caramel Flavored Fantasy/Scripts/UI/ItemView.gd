# INVENTORY VIEW
extends Panel

enum ItemViewState {OPTIONS, SELECT_ITEM}
var state = ItemViewState.OPTIONS

var inventory_items = []
onready var description = get_node("ItemDescription/DescriptionLbl")
onready var items_container = get_node("ScrollContainer/ItemsContainer")
onready var cursor = get_node("Cursor")

onready var useActionLbl = get_node("ItemHeader/UseActionLbl")

onready var sortActionLbl = get_node("ItemHeader/SortActionLbl")

var hero_select_view

var item_label = preload("res://Scenes/HUD/ItemLabel.tscn")


var item_labels = []

var item_database
var player_inventory
var timer
var active = false
var hero_view
var total_items
var ui_items = []
var items
var cursor_index = 0
var list_position = 0
var max_display_items = 10

var inventory_length = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	hero_view = get_parent().get_node("HeroView")
	hero_select_view = get_parent().get_node("HeroSelectView")
	timer = get_node("InputDelay")
	
	item_database = GameManager.GetItemDataBase()
	player_inventory = GameManager.inventory
	
	for i in range(max_display_items):
		var item = item_label.instance()
		items_container.add_child(item)
		item_labels.append(item)
		item.hide()

	
	items = player_inventory.GetItems()
	inventory_length = len(items)
	
	for i in range(max_display_items):
		var key = player_inventory.item_key_order[i]
		var item = GameManager.item_database.GetItemByID(key)
		item_labels[i].text = item.item_name + " x" + str(items[key])
		item_labels[i].show()
		ui_items.append(item)
		
	total_items = 10
	timer.connect("timeout",self,"OnTimerTimeout")

	PositionCursor()
	DescribeItem()
	
func ClearItemList():
	for i in range(max_display_items):
		item_labels[i].text = ""
		item_labels[i].hide()
	
func UpdateItemList():
	var list_min = 0
	var list_max = max_display_items
	
	print(list_position)
	if list_position >= max_display_items:
		list_min = list_position-9
		list_max = list_position+1
		
	ClearItemList()
	
	var j = 0
	
	for i in range(list_min, list_max):
		var key = player_inventory.item_key_order[i]
		var item = GameManager.item_database.GetItemByID(key)
		ui_items[j] = item
		item_labels[j].text = item.item_name + " x" + str(items[key])
		item_labels[j].show()
		j+=1
	
func OnTimerTimeout():
	active = true
	timer.stop()

func Activate():
	ClearDescription()
	ClearItemList()
	cursor.global_position = useActionLbl.rect_global_position +Vector2.LEFT*14 + Vector2.DOWN*7
	timer.start()
	state = ItemViewState.OPTIONS
	cursor_index=0
	items = player_inventory.GetItems()
	inventory_length = len(items)
	self.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		
		match(state):
			ItemViewState.OPTIONS:
				Options()
			ItemViewState.SELECT_ITEM:
				SelectItem()

				
func Options():
		# close the hero view
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
			cursor.global_position = useActionLbl.rect_global_position +Vector2.LEFT*14 + Vector2.DOWN*7
		1:
			cursor.global_position = sortActionLbl.rect_global_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
			
	if Input.is_action_just_pressed("accept"):
				
		match(cursor_index):
			0:
				UpdateItemList()
				DescribeItem()
				ChangeState(ItemViewState.SELECT_ITEM)
				PositionCursor()
			
func ChangeState(new_state):
	cursor_index=0
	state = new_state
	
func SelectItem():
	if Input.is_action_just_pressed("ui_cancel"):
		ChangeState(ItemViewState.OPTIONS)
		ClearDescription()
		return
		
	var changed = false
	if Input.is_action_just_pressed("move_down"):
		cursor_index += 1
		changed = true
		
		list_position += 1
		if cursor_index > total_items-1:
			cursor_index=total_items-1
		if list_position > inventory_length-1:
			list_position = inventory_length-1
			
	elif Input.is_action_just_pressed("move_up"):
		changed = true
		list_position -= 1
		if list_position < 0:
			list_position = 0
		
		if list_position < max_display_items-1:
			#update the cursor position
			cursor_index -= 1
		
			if cursor_index < 0:
				cursor_index = 0
	
	if changed:
		UpdateItemList()
		PositionCursor()
		DescribeItem()
		
	if Input.is_action_just_pressed("accept"):
		var item = ui_items[cursor_index]
		if item.item_type == item.ItemType.USE:
			hero_select_view.Setup(item.id)
			hero_select_view.Activate()
			Deactivate()

func Deactivate():
	active = false
	self.hide()
	
func ClearDescription():
	description.text = ""
		

func PositionCursor():
	cursor.global_position = items_container.rect_global_position + item_labels[cursor_index].rect_position + Vector2.LEFT*14 + Vector2.DOWN*7
	
		
func DescribeItem():
	description.text = ui_items[cursor_index].description

