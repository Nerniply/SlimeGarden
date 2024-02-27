extends Node2D
class_name Player

var maxhp = 25
var curhp = 25
var spd = 3
var direction = "X"

func _physics_process(delta):
	var input = Vector2()
	if Input.is_key_pressed(KEY_D):
		input.x = 1
		$AnimatedSprite2D.play("move_R")
		direction = "R"
	if Input.is_key_pressed(KEY_A):
		input.x = -1
		$AnimatedSprite2D.play("move_L")
		direction = "L"
	if Input.is_key_pressed(KEY_S):
		input.y = 1
		if direction == "R":
			$AnimatedSprite2D.play("move_R")
		else: $AnimatedSprite2D.play("move_L")
	if Input.is_key_pressed(KEY_W):
		input.y = -1
		if direction == "L":
			$AnimatedSprite2D.play("move_L")
		else: $AnimatedSprite2D.play("move_R")
	if !Input.is_key_pressed(KEY_D) and !Input.is_key_pressed(KEY_A) and !Input.is_key_pressed(KEY_S) and !Input.is_key_pressed(KEY_W):
		$AnimatedSprite2D.play("idle")
	position += input.normalized()*spd
	
	#var move = Vector2()
	#move.x = spd*(int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)))
	#move.y = spd*(int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))
	#position += move

func SetMaxHP(newhp):
	maxhp = newhp

func gethp():
	return curhp

# Controlls the dropping of health when taking damage
func drophp(amount):
	for i in range(amount):
		get_parent().add_child(load("res://health.tscn").instantiate())

# Controls collisions with various objects
func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if (area.get_parent().is_in_group("Enemy")):
			var enemyhp = area.get_parent().gethp()
			if (enemyhp < curhp):
				curhp -= enemyhp
				print(curhp)
				drophp(enemyhp)
			else:
				get_tree().reload_current_scene()
		if (area.get_parent() is Health):
			curhp += 1
			print(curhp)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
