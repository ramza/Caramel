#ITEM
extends Node

enum ItemType {WEAPON, ARMOR, USE, STORY}

enum EffectType {HEAL, CURE, REZ}

var item_type = ItemType.USE

var item_name = "Potion of Healing"
var id = 0
var description = "Drink this to recover a small amount of hp."

var attributes = {
	"value":0,
	"hp_regain": 8,
}




