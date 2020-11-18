extends "BasicView.gd"

onready var portrait = get_node("EquipMenu/HeroPortrait")
onready var equipLbl = get_node("EquipMenu/EquipInfoLbl")
onready var statsLbl = get_node("HeroStats/StatsLbl")

var hero_view
var hero_id = 0

onready var cursor = get_node("Cursor")
var item_database

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = GameManager.item_database
	hero_view = get_parent().get_node("HeroView")
	DisplayHeroEquipment(0)

func DisplayHeroEquipment(id):
	var hero = GameManager.hero_party.heroes[id]
	
	var equip_txt = ""
	var weapon = item_database.GetItemByID(hero.weapon_id)
	equip_txt += "Weapon: " + weapon.item_name + "\n"
	
	var armor = item_database.GetItemByID(hero.armor_id)
	equip_txt += "Armor: " + armor.item_name + "\n"
	
	var ring = item_database.GetItemByID(hero.ring_id)
	equip_txt += "Ring: " + ring.item_name + "\n"
	
	equipLbl.text = equip_txt
	
	var stats = ""
	
	stats += "Strength: \t" + str(hero.strength) + "\n"
	stats += "Dexterity: \t" + str(hero.dexterity) + "\n"
	stats += "Vitality: " + str(hero.vitality) + "\n"
	stats += "Intelligence: " + str(hero.intelligence) + "\n"
	stats += "Spirit: " + str(hero.spirit) + "\n"
	stats += "Charm: " + str(hero.charm) + "\n"
	
	statsLbl.text = stats
	
func _process(delta):
	# close the hero view
	if active and Input.is_action_just_pressed("ui_cancel"):
		hero_view.Activate()
		hero_view.show()
		active=false
		self.hide()

