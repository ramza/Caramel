# BATTLE UI
extends CanvasLayer

onready var action_panel = get_node("BattleContainer/ActionPanel")
onready var msg_panel = get_node("BattleContainer/MSGPanel")
onready var msg_text = get_node("BattleContainer/MSGPanel/RichTextLabel")

onready var enemy_selector=get_node("BattleContainer/EnemySelector")

var hero_panel = preload("res://Scenes/Battle/HeroPanel.tscn")
var heroes
var hero_panels = []

onready var hero_panel_container = get_node("BattleContainer/HeroPanelContainer/HBoxContainer")

onready var GUI = get_parent().get_node("GUI")

func SetupUI():
	enemy_selector.hide()
	action_panel.hide()
	msg_text.text = "Fight!"
	heroes = GameManager.hero_party.heroes
	
	for h in heroes:
		var hp = hero_panel.instance()
		hero_panel_container.add_child(hp)
		hero_panels.append(hp)
	
		
	msg_panel.show()
	UpdateHeroInfo()
	GUI.Transition(GUI.TransitionType.RISE)
	
	enemy_selector.Setup()
	
func StartActionPanel(hero_name):
	msg_panel.hide()
	action_panel.Activate(hero_name)

func NewBattleMSG(msg):

	msg_text.bbcode_text = msg
	msg_panel.show()
	
func UpdateHeroInfo():
	for i in range(len(hero_panels)):
		hero_panels[i].get_node("NameLbl").text = heroes[i].hero_name
		
		var stats = ""
		stats += "HP: " + str(heroes[i].curHP) + "/" + str(heroes[i].curHP) + "\n"
		stats += "MP " + str(heroes[i].curMP) + "/" + str(heroes[i].curMP)
		hero_panels[i].get_node("StatsLbl").text = stats
	

