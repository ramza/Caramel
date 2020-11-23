#ENEMY AI
extends Node

enum AttackType {WEAPON,MAGIC,SPECIAL,FINISHED,KO}

var attack_type = AttackType.WEAPON
var battle_manager
var enemy_data
var target 

var item_database

var enemy_attack

onready var timer = get_node("AITimer")

func _ready():
	item_database = GameManager.GetItemDataBase()

func Battle(enemy_data):
	self.enemy_data = enemy_data
	match(enemy_data.tactics):
		enemy_data.TacticsType.RANDOM:
			#choose random enemy
			attack_type = AttackType.WEAPON
			ChooseRandomTarget()

func ChooseRandomTarget():
	
	var living_heroes = []
	for h in battle_manager.heroes:
		if h.curHP > 0:
			living_heroes.append(h)
	
	var r = rand_range(0,len(living_heroes))
	var h = living_heroes[r]
	target = h
	battle_manager.battle_ui.NewBattleMSG(enemy_data.enemy_name + " " + enemy_data.attack_descriptions[0] + " " + h.hero_name + ".")
	timer.wait_time=1
	timer.start()

func _on_AITimer_timeout():
	timer.stop()
	if attack_type == AttackType.WEAPON:
		WeaponStrike()
	elif attack_type == AttackType.FINISHED:
		if target.curHP == 0:
			attack_type = AttackType.KO
			battle_manager.battle_ui.NewBattleMSG(target.hero_name + " fell unconscious.")
			timer.start()
		else:
			battle_manager.TakeNextTurn()
	elif attack_type == AttackType.KO:
		battle_manager.TakeNextTurn()
	
		
func WeaponStrike():
	
	var hero_weapon = item_database.GetItemByID(target.weapon_id)
	var hero_armor = item_database.GetItemByID(target.armor_id)
	
	#roll a d20
	var r = int(rand_range(1,20))
	
	var attack_roll = r + enemy_data.strength-10 + enemy_data.attack
	print("attack roll: " + str(attack_roll))
	if attack_roll > hero_armor.attributes["armor_bonus"]+target.dexterity:
		HandleWeaponDamage()
	else:
		HandleMiss()

	attack_type = AttackType.FINISHED
	timer.wait_time=2
	timer.start()
		
func HandleMiss():
	battle_manager.battle_ui.NewBattleMSG(enemy_data.enemy_name + " missed.")
		
func HandleWeaponDamage():
	
	var weapon_dmg = int(rand_range(1,enemy_data.strength-10) + 1)
	
	battle_manager.battle_ui.NewBattleMSG(enemy_data.enemy_name + " hit for " + str(weapon_dmg) + ".")
	battle_manager.camera.shake(1,14,6)
	target.curHP -= weapon_dmg
	if target.curHP <= 0:
		target.curHP = 0
		
	battle_manager.battle_ui.UpdateHeroInfo()
	
