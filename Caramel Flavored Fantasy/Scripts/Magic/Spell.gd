# SPELL
extends Node

enum MagicType {DARK, RADIANT, FIRE, WATER,LIGHTNING,}
#enum MagicClass {POTION,SWORD, SPEAR, BOW, DAGGER, AXE, LIGHT, HEAVY, MAGIC}
enum EffectType {DAMAGE, HEAL, CURE, REZ, STATUS}

var magic_type = MagicType.FIRE
var effect_type = EffectType.DAMAGE
#var item_class = ItemClass.POTION


var magic_name = "Fire 1"
var id = 0
var description = "Confure elemental flames to burn your enemies."

var attributes = {
	"damage": 8,
}

var spell_effect_adjectives = [
	"scorched","burnt","cooked","fried","toasted","crisped"
]




