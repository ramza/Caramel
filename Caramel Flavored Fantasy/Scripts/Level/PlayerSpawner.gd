# PLAYER SPAWNER
extends Node2D



var spawnpoints = []
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	
	spawnpoints = get_children()
	
	for spawn in spawnpoints:
		if spawn.name == GameManager.spawn_point:
			player.position = spawn.position
			return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
