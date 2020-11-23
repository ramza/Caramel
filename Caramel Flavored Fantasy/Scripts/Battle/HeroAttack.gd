# HERO ATTACK
extends Node2D

var hero
var enemy
onready var timer = get_node("Timer")

var battle_manager
var battle_ui

enum AttackState {HURT,KILL}
var state = AttackState.HURT


func Setup():
	
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]
	battle_ui = battle_manager.battle_ui
	
# Called when the node enters the scene tree for the first time.
	timer.connect("timeout",self,"OnTimerTimeout")

func OnTimerTimeout():
	timer.stop()
	if state == AttackState.KILL:
		queue_free()
	
	if enemy.curHP <= 0:
		state = AttackState.KILL
		battle_ui.NewBattleMSG(hero.hero_name + " defeated the " + enemy.enemy_name + ".")
		timer.start()
	
func Attack(hero,enemy):
	self.hero = hero
	self.enemy = enemy
	timer.start()

	
