#ITEM
extends Node

enum ItemType {WEAPON, ARMOR, USE, STORY}
enum ItemClass {POTION,SWORD, SPEAR, BOW, DAGGER, AXE, LIGHT, HEAVY}
enum EffectType {HEAL, CURE, REZ}

var item_type = ItemType.USE
var effectType = EffectType.CURE
var item_class = ItemClass.POTION

var item_name = "Potion of Healing"
var id = 0
var description = "Drink this to recover a small amount of hp."

var attributes = {
	"value": 10,
	"hp_bonus": 8,
}




