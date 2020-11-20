#ITEM
extends Node

enum ItemType {WEAPON, ARMOR, RING, USE, STORY,EMPTY}
enum ItemClass {POTION,SWORD, SPEAR, BOW, DAGGER, AXE, LIGHT, HEAVY, MAGIC}
enum EffectType {HEAL, CURE, REZ}

var item_type = ItemType.USE
var effect_type = EffectType.CURE
var item_class = ItemClass.POTION

var item_name = "Potion of Healing"
var id = 0
var description = "Drink this to recover a small amount of hp."

var attributes = {
	"value": 10,
	"hp_bonus": 8,
}




