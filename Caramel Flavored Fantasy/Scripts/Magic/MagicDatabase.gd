# MAGIC DATABASE
extends Node

var spell = preload("res://Scripts/Magic/Spell.gd")


var spells = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func BuildSpellDatabase():
	var s = spell.instance()
	
	s.magic_type = s.MagicType.FIRE
	s.effect_type = s.EffectType.DAMAGE

	s.magic_name = "Fire 1"
	s.id = 0
	s.description = "Confure elemental flames to burn your enemies."

	s.attributes = {
	"damage": 8,
	}

	s.spell_effect_adjectives = ["scorched","burnt","cooked","fried","toasted","crisped"]
	spells.append(s)
