# ENEMY PARTY
extends Node

onready var enemy_panel =get_parent().get_parent().get_node("BattleUI/BattleContainer/EnemyActorsPanel")

var spawnpoints = []

onready var enemy_database = get_node("EnemyDataBase")
var enemy_data = preload("res://Scenes/Battle/EnemyData.tscn")

var enemy_battle_node = preload("res://Scenes/Battle/EnemyBattleNode.tscn")

var enemies = []

var enemy_nodes = []

# Called when the node enters the scene tree for the first time.
func Setup():
	enemy_database.BuildDatabase()
	for e in GameManager.enemy_list:
		var enemy = enemy_database.CopyEnemy(e)
		enemies.append(enemy)
		

	spawnpoints = enemy_panel.get_children()
	SpawnEnemies()

func SpawnEnemies():
	if len(enemies) == 1:
		var e = enemy_battle_node.instance()
		enemy_panel.add_child(e)
		e.position = spawnpoints[2].position
		e.enemy = enemies[0]
		enemy_nodes.append(e)
		return
	
	for i in range(len(enemies)):
		var e = enemy_battle_node.instance()
		enemy_panel.add_child(e)
		e.position = spawnpoints[i].position
		e.enemy = enemies[i]
		enemy_nodes.append(e)
	
	
