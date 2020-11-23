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
onready var endTurnTimer=get_node("EndTurnTimer")
var cursor_position_modifier = Vector2.UP*50
onready var attack_roll_timer = get_node("AttackRollTimer")
var item_database

# Called when the node enters the scene tree for the first time.
func Setup():
	attack_roll_timer.connect("timeout",self,"_on_AttackRollTimer_Timeout")
	endTurnTimer.connect("timeout",self,"_on_EndTurnTimer_Timeout")
	timer.connect("timeout",self,"OnTimerTimeout")
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]
	battle_ui = battle_manager.battle_ui
	
	action_panel = battle_manager.battle_ui.action_panel
	item_database = GameManager.GetItemDataBase()

func OnTimerTimeout():
	timer.stop()
	active = true
	
func _on_AttackRollTimer_Timeout():
	attack_roll_timer.stop()
	MakeAttackRoll()

	
func _on_EndTurnTimer_Timeout():
	endTurnTimer.stop()
	battle_manager.TakeNextTurn()
	Deactivate()

func Activate(hero,action_type):
	self.action_type = action_type
	cursor_index = 0
	cur_hero= hero
	cursor.show()
	enemyInfoLbl.show()
	weapon = item_database.GetItemByID(cur_hero.weapon_id)
	ring = item_database.GetItemByID(cur_hero.ring_id)
	
	timer.start()
	enemies.clear()
	
	for e in battle_manager.enemy_party.enemy_nodes:
		if e.enemy.curHP > 0:
			enemies.append(e)
			
	#print("total enemies: " + str(len(enemies)))
	enemyInfoLbl.text = enemies[cursor_index].enemy.enemy_name
	cursor.global_position = enemies[cursor_index].global_position+cursor_position_modifier
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
		cursor.global_position = enemies[cursor_index].global_position+cursor_position_modifier
		var cur_enemy = enemies[cursor_index].enemy
		if Input.is_action_just_pressed("accept"):
			match(action_type):
				action_panel.ActionType.FIGHT:
					enemyInfoLbl.hide()
					cursor.hide()
					DeselectAllEnemies()
					active =false
					attack_roll_timer.start()
					battle_ui.NewBattleMSG(cur_hero.hero_name + " tries to attack the " + cur_enemy.enemy_name + ".")
					

func MakeAttackRoll():
	var enemy = enemies[cursor_index]
	var weapon = item_database.GetItemByID(cur_hero.weapon_id)
	var r = int(rand_range(1,20)) #roll a d20
	print(cur_hero.hero_name + " rolled a " + str(r))
	if r + ((cur_hero.strength-10)/2) > enemy.enemy.defense + enemy.enemy.dexterity:
		AttackEnemy()
	else:
		battle_ui.NewBattleMSG(cur_hero.hero_name + " missed")
		endTurnTimer.start()


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
	
	var r = int(rand_range(1,6))
	dmg = r + int(((cur_hero.strength-10)/2)) + weapon.attributes["damage_bonus"] + ring.attributes["strength_bonus"]
	
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
