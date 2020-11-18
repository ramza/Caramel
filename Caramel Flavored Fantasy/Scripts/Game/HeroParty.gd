# HERO PARTY
extends Node

var hero_data = preload("res://Scenes/Game/HeroData.tscn")

var heroes = []

# Called when the node enters the scene tree for the first time.
func AddSid():
	var sid = hero_data.instance()

	sid.strength=16
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
	
	add_child(sid)
	heroes.append(sid)
	
func AddStar():
	var star = hero_data.instance()
	
	star.strength=16
	star.dexterity=14
	star.vitality=12
	star.intelligence=14
	star.spirit=16
	star.charm=16
	
	star.hero_name = "Star"
	star.character_class = "Rogue"

	star.weapon_id = 1
	star.armor_id = 2
	star.ring_id = 99
	
	add_child(star)
	heroes.append(star)
	
	
	

	
