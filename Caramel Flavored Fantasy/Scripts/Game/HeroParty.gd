# HERO PARTY
extends Node

var hero_data = preload("res://Scenes/Game/HeroData.tscn")

var heroes = []

# Called when the node enters the scene tree for the first time.
func AddSid():
	var sid = hero_data.instance()

	sid.curHP = 10
	sid.maxHP = 22
	sid.curMP = 5
	sid.maxMP = 5

	sid.strength=12
	sid.dexterity=14
	sid.vitality=12
	sid.intelligence=14
	sid.spirit=16
	sid.charm=16
	
	sid.hero_name = "Sid"
	sid.character_class = "Fighter"
	
	sid.weapon_id = 1
	sid.armor_id = 2
	sid.ring_id = 99
	sid.unit_type = sid.UnitType.PLAYER
	add_child(sid)
	heroes.append(sid)
	
func AddStar():
	var star = hero_data.instance()
	
	star.curHP = 18
	star.maxHP = 18
	star.curMP = 7
	star.maxMP = 7

	star.strength=10
	star.dexterity=14
	star.vitality=12
	star.intelligence=14
	star.spirit=16
	star.charm=16
	
	star.hero_name = "Star"
	star.character_class = "Rogue"

	star.unit_type = star.UnitType.PLAYER

	star.weapon_id = 1
	star.armor_id = 2
	star.ring_id = 99
	
	add_child(star)
	heroes.append(star)
	
	
	

	
