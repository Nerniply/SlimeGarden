extends Node2D

@onready var player = get_parent().get_parent().get_node("Rosa") #
var spd = 0 #
#var spd = 4 #= 266 on CharacterBody2D nodes
var explosion = preload("res://explosion.tscn").instantiate()
var timervar = 0 #
var targetDirection # direction toward player; only updated during first 120 frames (2 sec)



# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = get_parent().global_position + Vector2(0,-30) #
	#self.position = get_parent().get_node("AnimatedSprite2D").position + Vector2(0, -30)

func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if area.get_parent().is_in_group("Solid"):
			queue_free()
			explosion.position = self.position # global_
			explosion.size = 2.5
			get_parent().add_child(explosion)
			get_parent().get_node("FireballIndicator").canDespawn = true
		if area.get_parent().get_parent() == self.get_parent():
			queue_free()
			get_parent().get_node("FireballIndicator").canDespawn = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	if timervar < 120: #
		targetDirection = (player.global_position - self.global_position).normalized() #
	else: #
		self.spd = 4 #
		self.global_position += targetDirection * spd #
	timervar += 1 #
	
#	if get_parent().getShoot():
#		position += (get_parent().getTarget() + Vector2(0, 30)).normalized() * spd
		#velocity = position.direction_to(get_parent().getTarget()) * spd
		#move_and_slide()

