# HERO DATA
extends Node

# BASIC STATS FOR THE PLAYER HEROES

enum HeroStatus {OK,POISON,DARK,FURY}

var curHP = 1
var maxHP = 1
var curMP = 0
var maxMP = 0

var level = 1

var status = HeroStatus.OK

var strength=16
var dexterity=14
var vitality=12
var intelligence=14
var spirit=16
var charm=12
var magic=3

var hero_name = "Sid"
var character_class = "Fighter"

var weapon_id
var armor_id
var ring_id

