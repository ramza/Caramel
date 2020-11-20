# BATTLE MANAGER
extends Node


var heroes = []
var enemy_party = get_parent().get_node("EnemyParty")

onready var battle_timer = get_node("BattleTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	battle_timer.connect("timeout",self,"OnBattleTimerTimeout")
	heroes = GameManager.hero_party.heroes
	
func BattleIntro():
	pass
	
func SpawnEnemies():
	pass

func OnBattleTimerTimeout():
	battle_timer.stop()
	
func TakeNextTurn():
	pass

