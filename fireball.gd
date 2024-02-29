extends Node2D

var spd


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("AnimatedSprite2D").position = get_parent().get_node("AnimatedSprite2D").position + Vector2(0, -30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().readyToShoot:
		queue_free()
	

func _physics_process(delta):
	#if get_parent().getShoot():
	#	position += (get_parent().getTarget()).normalized() * spd
	#	move_and_slide()
	pass	
