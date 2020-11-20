# BATTLE UI
extends CanvasLayer

onready var action_panel = get_node("Container/ActionPanel")
onready var msg_panel = get_node("Container/MSGPanel")
onready var msg_text = get_node("Container/MSGPanel/RichTextLabel")

var hero_panel = preload("res://Scenes/Battle/HeroPanel.tscn")
var heroes
var hero_panels = []

onready var hero_panel_container = get_node("BattleContainer/HeroPanelContainer")

func _ready():
	action_panel.hide()
	msg_text.text = "Fight!"
	heroes = GameManager.hero_party.heroes
	
	for h in heroes:
		var hp = hero_panel.instance()
		hero_panel_container.add_child(hp)
		hero_panels.append(hp)

func NewBattleMSG(msg):
	msg_text.text = msg
	
func UpdateHeroInfo():
	pass
	
	

