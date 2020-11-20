extends Node


var item_database
var inventory
var hero_party

var enemy_list = ["Slime"]

var spawn_point = "Main"
# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = get_node("ItemDatabase")
	item_database.BuildDatabase()
	
	inventory = get_node("PlayerInventory")
	hero_party = get_node("HeroParty")
	hero_party.AddSid()
	hero_party.AddStar()

func GetItemDataBase():
	return item_database
