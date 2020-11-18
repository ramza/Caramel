# ENEMY PARTY
extends Node


onready var enemy_database = get_node("EnemyDataBase")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_database.BuildDatabase()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
