# ITEM PANEL
extends Panel


var item_database
var player_inventory
var active = false
var items = []
var use_items = []

var action_panel
var item_label_list = []
var item_label = preload("res://Scenes/HUD/ItemLabel.tscn")
onready var vbox = get_node("VBoxContainer")

var cursor_index = 0
var max_display_items = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = GameManager.GetItemDataBase()	
	player_inventory = GameManager.inventory
	items = player_inventory.item_key_order
	action_panel = get_parent().get_node("ActionPanel")
	
	for i in range(max_display_items):
		var item = item_label.instance()
		vbox.add_child(item)
		item_label_list.append(item)
		
	hide()

func Activate():
	GetUsableItems()
	DrawItems()

	active = true
	show()
	
func GetUsableItems():
	use_items.clear()
	
	for id in items:
		var item = item_database.GetItemByID(id)
		if item.item_type == item.ItemType.USE:
			use_items.append(item)

func DrawItems():
	
	for i in range(max_display_items):
		item_label_list[i].hide()
	
	if len(use_items) < max_display_items:
		max_display_items = len(use_items)
	
	for i in range(max_display_items):
		var item = use_items[i]
		item_label_list[i].text = item.item_name
		item_label_list[i].show()
		pass
	
func _process(delta):
	if active:
		
		pass

