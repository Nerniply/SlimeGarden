extends CharacterBody2D
class_name Player

var maxhp = 20
var curhp = 20
var spd = 200
var direction = "X"
var input = Vector2()
var spdup
var spduptimer
var pacman
var pactimer

func SetMaxHP(newhp):
	maxhp = newhp

func gethp():
	return curhp

# Controlls the dropping of health when taking damage
func drophp(amount):
	for i in range(amount):
		get_parent().add_child(load("res://health_slime.tscn").instantiate())

# Controls collisions with various objects
func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if (area.get_parent().is_in_group("Enemy")) and !pacman:
			#$AnimatedSprite2D.modulate = Color(1, 0, 0)
			var enemyhp = area.get_parent().gethp()
			if (enemyhp < curhp):
				curhp -= enemyhp
				#print(curhp)
				drophp(enemyhp)
			else:
				get_tree().reload_current_scene()
		if (area.get_parent() is Health) and curhp < maxhp:
			curhp += 1
			#print(curhp)
		if (area.get_parent() is FullHeal):
			curhp = maxhp
		if (area.get_parent() is SpeedBoost):
			spdup = true
			spduptimer = 0
			spd *= 2
		if (area.get_parent() is PacMan):
			pacman = true
			pactimer = 0
	#$healthtxt.text = str(curhp)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if curhp > maxhp:
		curhp = maxhp
	
	if spdup and spduptimer < 600:
		spduptimer += 1
		if spduptimer == 600:
			spd /= 2
	else:
		spdup = false

	if pacman and pactimer < 600:
		pactimer += 1
	else: pacman = false
	
	input = Vector2(0,0)
	if Input.is_key_pressed(KEY_D):
		input.x += 1
	else:
		input.x += 0
	if Input.is_key_pressed(KEY_A):
		input.x -= 1
	else:
		input.x -= 0
	if Input.is_key_pressed(KEY_S):
		input.y += 1
	else:
		input.y += 0
	if Input.is_key_pressed(KEY_W):
		input.y -= 1
	else:
		input.y -= 0
	velocity = input.normalized()*spd
	move_and_slide()
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true # right
		$AnimatedSprite2D.play("move_L")
		direction = "R"
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false # left
		$AnimatedSprite2D.play("move_L")
		direction = "L"
	if velocity.x == 0:
		if velocity.y > 0:
			if direction == "R":
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("move_L")
		if velocity.y < 0:
			if direction == "L":
				$AnimatedSprite2D.flip_h = false # left
			else: $AnimatedSprite2D.flip_h = true # right
			$AnimatedSprite2D.play("move_L")
		if velocity.y == 0:
			$AnimatedSprite2D.play("idle")
