# BATTLE MANAGER
extends Node


var heroes = []
var enemies = []

onready var battle_timer = get_node("BattleTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	battle_timer.connect("timeout",self,"OnBattleTimerTimeout")
	heroes = GameManager.hero_party.heroes
	pass # Replace with function body.

func OnBattleTimerTimeout():
	battle_timer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
