# ENEMY DATA
extends "BattleUnit.gd"



enum EnemyType {OOZE,GOBLIN,DRAGON,ORC,GIANT,TROLL}

var curHP = 1
var maxHP = 1
var curMP = 0
var maxMP = 0

var strength=16
var dexterity=14
var vitality=12
var intelligence=14
var spirit=16
var charm=12

var enemy_name = "Slime"
var enemy_type = EnemyType.OOZE

var image_name = "jelly"

var items_to_drop = [0]
var chance_to_drop = 5
var critical_strike_chance = 5.0 # percentage

var attack_descriptions = [
	"tries to slam",
]





