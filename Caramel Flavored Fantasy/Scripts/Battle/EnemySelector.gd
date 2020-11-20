# ENEMY SELECTOR
extends Node2D

var action_type

var battle_manager 
var enemies = []
onready var cursor = get_node("Cursor")
onready var enemyInfoLbl = get_node("EnemyInfoPanel/EnemyInfoLbl")
var active = false
var cursor_index=0
var action_panel
onready var timer = get_node("EnemySelectTimer")
var cur_hero
var battle_ui
var weapon
var ring

var hero_attack = preload("res://Scenes/Battle/HeroAttack.tscn")

var item_database

# Called when the node enters the scene tree for the first time.
func Setup():
	timer.connect("timeout",self,"OnTimerTimeout")
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]
	battle_ui = battle_manager.battle_ui
	
	action_panel = battle_manager.battle_ui.action_panel
	item_database = GameManager.GetItemDataBase()

func OnTimerTimeout():
	timer.stop()
	active = true

func Activate(hero,action_type):
	self.action_type = action_type

	cur_hero= hero
	
	weapon = item_database.GetItemByID(cur_hero.weapon_id)
	ring = item_database.GetItemByID(cur_hero.ring_id)
	
	timer.start()
	enemies.clear()
	
	for e in battle_manager.enemy_party.enemy_nodes:
		if e.enemy.curHP > 0:
			enemies.append(e)
			
	print("total enemies: " + str(len(enemies)))
	enemyInfoLbl.text = enemies[cursor_index].enemy.enemy_name
	cursor.global_position = enemies[cursor_index].global_position+Vector2.UP*30
	self.show()
	
func Deactivate():
	DeselectAllEnemies()
	active = false
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		
		if Input.is_action_just_pressed("ui_cancel"):
			action_panel.Activate(cur_hero.hero_name)
			Deactivate()
			return
		
		if Input.is_action_just_pressed("move_left"):
			cursor_index -= 1
			if cursor_index < 0:
				cursor_index=0
		elif Input.is_action_just_pressed("move_right"):
			cursor_index += 1
			if cursor_index > len(enemies)-1:
				cursor_index = len(enemies)-1
		
		enemyInfoLbl.text = enemies[cursor_index].enemy.enemy_name
		HighlightEnemies()
		cursor.global_position = enemies[cursor_index].global_position+Vector2.UP*30
	
		if Input.is_action_just_pressed("accept"):
			match(action_type):
				action_panel.ActionType.FIGHT:
					AttackEnemy()

func AttackEnemy():
	var enemy = enemies[cursor_index]
	var weapon = item_database.GetItemByID(cur_hero.weapon_id)
	var dmg = CalculateAttackDamage()
	enemy.enemy.curHP -= dmg
	
	battle_ui.NewBattleMSG(cur_hero.hero_name + " attacked the enemy for [color=red]" + str(dmg) + "[/color] damage.")
	
	var new_attack = hero_attack.instance()
	add_child(new_attack)
	new_attack.Setup()
	new_attack.Attack(cur_hero,enemy.enemy)
	
	enemy.Flash()
	Deactivate()
	
func CalculateAttackDamage():
	var dmg = 0
	

	dmg = cur_hero.strength-10 + weapon.attributes["damage_bonus"] + ring.attributes["strength_bonus"]
	
	return dmg

func HighlightEnemies():
	for i in range(len(enemies)):
		if i == cursor_index:
			enemies[i].Select()
		else:
			enemies[i].Deselect()
			
func DeselectAllEnemies():
	for i in range(len(enemies)):
		enemies[i].Deselect()
