extends Node2D

@onready var player = get_parent().get_node("Rosa")
@onready var dir = get_parent().ArrowDir
var hp = 2
var spd = 10
var targetDirection

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(dir)
	var screenheight = get_viewport().size.y/(2*player.get_node("PlayerCam").get_zoom().y)
	var spawnY = player.global_position.y + randi_range(-screenheight,screenheight) # based on screen size
	var spawnX = get_viewport().size.x/(2*player.get_node("PlayerCam").get_zoom().x) # based on viewport and zoom
	self.global_position = Vector2(player.global_position.x - (dir * spawnX), spawnY)
	var endPos = Vector2(player.global_position.x + (dir * spawnX), spawnY)
	look_at(endPos)
	targetDirection = (endPos - self.global_position).normalized()

func gethp():
	return hp

func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if area.get_parent().is_in_group("Solid"):
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position += targetDirection * spd


