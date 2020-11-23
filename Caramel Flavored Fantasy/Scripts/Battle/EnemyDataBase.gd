# ENEMY DATABASE
extends Node

var enemy_data = preload("res://Scenes/Battle/EnemyData.tscn")

var enemies = []

func BuildDatabase():
	
	var slime = enemy_data.instance()
	slime.curHP = 12
	slime.maxHP = 12
	slime.curMP = 0
	slime.maxMP = 0
	slime.strength=15
	slime.dexterity=7
	slime.vitality=7
	slime.intelligence=2
	slime.spirit=4
	slime.charm=2
	
	slime.attack = 2
	slime.defense = 3
	
	slime.enemy_name = "Slime"
	slime.enemy_type = slime.EnemyType.OOZE
	slime.critical_strike_chance=5
	slime.items_to_drop = [0]
	slime.attack_descriptions = [
	"tries to slam",
	]
	enemies.append(slime)
	

func CopyEnemy(name):
	var e = GetEnemyByName(name)
	var enemy = enemy_data.instance()
	enemy.strength = e.strength
	enemy.dexterity = e.dexterity
	enemy.vitality = e.vitality
	enemy.intelligence = e.intelligence
	enemy.spirit = e.spirit
	enemy.charm = e.charm
	enemy.curHP = e.curHP
	enemy.maxHP = e.maxHP
	enemy.curMP = e.curMP
	enemy.maxMP = e.curMP
	enemy.attack = e.attack
	enemy.defense = e.defense
	
	enemy.enemy_name = e.enemy_name
	enemy.enemy_type = e.enemy_type
	enemy.critical_strike_chance = e.critical_strike_chance
	enemy.attack_descriptions = e.attack_descriptions	
	
	return enemy
	
func GetEnemyByID(id):
	for enemy in enemies:
		if enemy.id == id:
			return enemy
			
func GetEnemyByName(name):
	for enemy in enemies:
		if enemy.enemy_name == name:
			return enemy

	
	
	
