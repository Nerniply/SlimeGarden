extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if (area.get_parent() is Player):
		#Music.play()
		#Fading.play("FadeIn")
		area.get_parent().get_node("PlayerCam").set_zoom(Vector2(2,2))
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_LEFT,-2723)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_TOP,-1880)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_RIGHT,-1443)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_BOTTOM,-1080)