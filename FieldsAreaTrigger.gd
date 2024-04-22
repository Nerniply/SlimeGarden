extends Area2D
@onready var Fading = $FieldAnimationPlayer
@onready var Music = $FieldMoozikPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if (area.get_parent() is Player):
		Music.play()
		Fading.play("FadeIn")
		area.get_parent().get_node("PlayerCam").set_zoom(Vector2(1,1))
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_LEFT,-1920)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_TOP,-1080)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_RIGHT,1920)
		area.get_parent().get_node("PlayerCam").set_limit(SIDE_BOTTOM,1080)


func _on_area_exited(area):
	if (area.get_parent() is Player):
		Fading.play("FadeOut")
