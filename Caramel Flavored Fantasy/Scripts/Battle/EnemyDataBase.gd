# ENEMY DATABASE
extends Node

var enemy_data = preload("res://Scenes/Battle/EnemyData.tscn")

var enemies = []

func BuildDatabase():
	
	var slime = enemy_data.instance()
	slime.strength=9
	slime.dexterity=7
	slime.vitality=7
	slime.intelligence=2
	slime.spirit=4
	slime.charm=2
	
	slime.enemy_name = "Slime"
	slime.enemy_type = slime.EnemyType.OOZE
	slime.critical_strike_chance=5
	slime.items_to_drop = [0]
	slime.attack_descriptions = [
	"tries to slam",
	]
	enemies.append(slime)
	
	
	
	
