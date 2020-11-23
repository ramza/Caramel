# BATTLE MANAGER
extends Node


var heroes = []
var enemies = []
onready var enemy_party = get_node("EnemyParty")

var battle_index = 0

var battle_order = []

onready var camera = get_parent().get_node("CustomeCamera2D")

onready var battle_ui = get_parent().get_node("BattleUI")
onready var battle_timer = get_node("BattleTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	battle_timer.connect("timeout",self,"OnBattleTimerTimeout")
	heroes = GameManager.hero_party.heroes
	
	enemy_party.Setup()
	enemies = enemy_party.enemies
	
	battle_ui.SetupUI()
	
	BattleIntro()
	
func DetermineBattleOrder():
	battle_order.clear()
	
	for h in heroes:
		if h.curHP > 0:
			battle_order.append(h)
	
	for e in enemies:
		if e.curHP > 0:
			battle_order.append(e)
			
	var swap = true
	
	while(swap):
		swap = false
		for i in range(len(battle_order)-1):
			if battle_order[i].dexterity < battle_order[i+1].dexterity:
				var u = battle_order[i]
				battle_order[i] = battle_order[i+1]
				battle_order[i+1]=u
				swap = true
				
	for u in battle_order:
		if u.unit_type == u.UnitType.PLAYER:
			print(u.hero_name)
		else:
			print(u.enemy_name)
				
func BattleIntro():
	DetermineBattleOrder()
	var msg = "Enemy Attack!"
	
	battle_ui.NewBattleMSG(msg)
	
	battle_timer.start()
	
func IsVictory():
	var dead_enemies = 0
	
	for e in enemies:
		if e.curHP < 1:
			dead_enemies += 1
			
	return dead_enemies == len(enemies)

func IsDefeat():
	var dead_heroes = 0
	
	for h in heroes:
		if h.curHP < 1:
			dead_heroes += 1
	
	return dead_heroes == len(heroes)

func OnBattleTimerTimeout():
	battle_timer.stop()
	TakeNextTurn()
	
func WonBattle():
	battle_ui.NewBattleMSG("Victory! You defeated the enemy.")
	
func LostBattle():
	battle_ui.NewBattleMSG("You were defeated.")
	
func TakeNextTurn():
	
	if IsVictory():
		WonBattle()
		return
	elif IsDefeat():
		LostBattle()
		return
	
	var unit = battle_order[battle_index]
	battle_index += 1
	if battle_index > len(battle_order)-1:
		battle_index = 0
	
	#print("take next turn")
	if unit.curHP <= 0:
		TakeNextTurn()
		return
		
	print(battle_index)
	if unit.unit_type == unit.UnitType.PLAYER:
		PlayerTurn(unit)
	else:
		EnemyTurn(unit)

func EnemyTurn(unit):
	
	for e in enemy_party.enemy_nodes:
		if e.enemy == unit:
			e.TakeTurn()

func PlayerTurn(unit):
	battle_ui.StartActionPanel(unit.hero_name)
	

