# ENEMY BATTLE NODE
extends Node2D

var enemy

onready var sprite = get_node("Sprite")

onready var timer = get_node("Timer")
onready var FadeTimer = get_node("FadeTimer")
var max_flash = 5
var flash_count = 0
const FADE_AMOUNT = 0.05
var flashing = false
var shader = preload("res://Other/Shaders/InvertedColor.tres")

var sprite_alpha = 1

var battle_manager

func _ready():
	battle_manager = get_tree().get_nodes_in_group("BattleManager")[0]

func Select():
	sprite.material=shader
	
func Deselect():
	sprite.material = null

func Flash():
	flashing=true
	flash_count = 0
	Deselect()
	timer.start()
	
func KillMonster():
	print("kill monster")
	Deselect()
	sprite.modulate = Color.red
	FadeTimer.start()

func _on_Timer_timeout():
	flash_count += 1
	timer.start()
	if flash_count > max_flash:
		if enemy.curHP<=0:
			KillMonster()
		
		timer.stop()
		sprite.modulate = Color.white
		return
	
	if flashing:
		flashing=false
		sprite.modulate = Color.red

	else:

		flashing=true
		sprite.modulate = Color.white


func _on_FadeTimer_timeout():
	sprite_alpha -= FADE_AMOUNT
	sprite.modulate = Color(sprite.modulate.r,sprite.modulate.g,sprite.modulate.b,sprite_alpha)
	
	if sprite_alpha <= -1:
		FadeTimer.stop()
		battle_manager.TakeNextTurn()
		

