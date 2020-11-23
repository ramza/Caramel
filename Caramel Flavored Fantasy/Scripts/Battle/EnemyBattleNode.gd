# ENEMY BATTLE NODE
extends Node2D

var enemy

onready var sprite = get_node("Sprite")

onready var timer = get_node("Timer")
onready var FadeTimer = get_node("FadeTimer")
var max_flash = 5
var flash_count = 0
const FADE_AMOUNT = 0.1
var flashing = false
var shader = preload("res://Other/Shaders/InvertedColor.tres")

var white_shader = preload("res://Other/Shaders/WhiteSilouette.tres")

var sprite_alpha = 1

var battle_manager

onready var enemyAI = get_node("EnemyAI")
onready var endTurnTimer = get_node("EndTurnTimer")
func _ready():
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]
	enemyAI.battle_manager = battle_manager

func Select():
	sprite.material=shader
	
func Deselect():
	sprite.material = null

func Flash():
	flashing=true
	flash_count = 0
	Deselect()
	timer.start()
	
func TakeTurn():
	enemyAI.Battle(enemy)
	
func KillMonster():
	Deselect()
	FadeTimer.start()

func _on_Timer_timeout():
	flash_count += 1
	timer.start()
	if flash_count > max_flash:
		if enemy.curHP<=0:
			KillMonster()
		else:
			endTurnTimer.start()
		
		timer.stop()
		sprite.material = null
		return
	
	if flashing:
		flashing=false
		sprite.material = white_shader

	else:

		flashing=true
		sprite.material = null


func _on_FadeTimer_timeout():
	sprite_alpha -= FADE_AMOUNT
	sprite.modulate = Color(sprite.modulate.r,sprite.modulate.g,sprite.modulate.b,sprite_alpha)
	
	if sprite_alpha <= -1:
		FadeTimer.stop()
		battle_manager.TakeNextTurn()
		

func _on_EndTurnTimer_timeout():
	endTurnTimer.stop()
	battle_manager.TakeNextTurn()
	
