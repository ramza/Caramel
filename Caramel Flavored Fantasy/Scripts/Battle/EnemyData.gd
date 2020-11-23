# ENEMY DATA
extends "BattleUnit.gd"

enum EnemyType {OOZE,GOBLIN,DRAGON,ORC,GIANT,TROLL}

enum TacticsType {RANDOM,SPELL,FIGHTER,BERZERK,DEFENSIVE}

var curHP = 1
var maxHP = 1
var curMP = 0
var maxMP = 0

var strength=20
var dexterity=14
var vitality=12
var intelligence=14
var spirit=16
var charm=12

var named = false

var enemy_name = "Slime"
var enemy_type = EnemyType.OOZE
var tactics = TacticsType.RANDOM

var image_name = "jelly"

var items_to_drop = [0]
var chance_to_drop = 5
var critical_strike_chance = 5.0 # percentage

var attack = 1
var defense = 1

var attack_descriptions = [
	"tries to slam",
]

