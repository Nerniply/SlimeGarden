extends Node2D
@onready var player = get_parent().get_node("Rosa")
@onready var screenview = Vector2(get_viewport().size.x/(2*player.get_node("PlayerCam").get_zoom().x), get_viewport().size.y/(2*player.get_node("PlayerCam").get_zoom().y))
var explosion = preload("res://explosion.tscn").instantiate()
var timervar = 0 #

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = player.position + Vector2(randi_range(-screenview.x,screenview.x),randi_range(-screenview.y,screenview.y))
	#self.position = Vector2(player.position.x + randi_range(-640,640), player.position.y + randi_range(-360, 360))
	explosion.position = self.position
	explosion.size = 5
#	explosion.rotated(randf_range(0, 2*PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	position = get_parent().getTarget()


func _physics_process(delta):
	if timervar == 60: #
		get_parent().add_child(explosion)
		queue_free()
	timervar += 1
