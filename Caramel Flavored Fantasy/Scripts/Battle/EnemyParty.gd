# ENEMY PARTY
extends Node


onready var enemy_database = get_node("EnemyDataBase")

var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_database.BuildDatabase()
	for e in GameManager.enemy_list:
		var enemy = enemy_database.GetEnemyByName(e)
		add_child(enemy)
		enemies.append(enemy)
				
	
	
