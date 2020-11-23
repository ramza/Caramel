#HUD
extends CanvasLayer

#The HUD is in charge of the player menu system

onready var hero_view = get_node("HeroView")
onready var item_view = get_node("ItemView")
onready var equip_view = get_node("EquipView")
onready var status_view = get_node("StatusView")
onready var hero_select_view = get_node("HeroSelectView")
var paused = false
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	HideAllViews()

func _process(delta):
	if not paused and Input.is_action_just_pressed("ui_cancel"):
		paused=true
		OpenPlayerMenu()

func OpenPlayerMenu():
	hero_view.show()
	hero_view.Activate()
	player.Freeze()
	
func ClosePlayerMenu():
	HideAllViews()
	hero_view.active=false
	player.Release()
	paused=false
	
func HideAllViews():
	hero_view.hide()
	item_view.hide()
	hero_select_view.hide()
	equip_view.hide()
	status_view.hide()

