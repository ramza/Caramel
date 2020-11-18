# HERO VIEW
extends "BasicView.gd"


var positions = []
var cursor_index = 0
var item_view
var equip_view

onready var cursor = get_node("HeroOptions/Cursor")
# Called when the node enters the scene tree for the first time.
func _ready():
	

	item_view = get_parent().get_node("ItemView")
	equip_view = get_parent().get_node("EquipView")
	
	positions = $HeroOptions.get_children()
	positions.remove(len(positions)-1)
	
	PositionCursor()
	
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
		get_parent().ClosePlayerMenu()
		active=false
		self.hide()
		cursor_index=0
		
func PositionCursor():
	cursor.position = positions[cursor_index].rect_position + (Vector2.RIGHT * -10)+(Vector2.DOWN*7)
	
