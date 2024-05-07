extends Area2D

var respawntimer = 0
var drowning
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if drowning:
		if respawntimer < 60:
			respawntimer += 1
		else:
			$StaticBody2D.set_collision_layer(1792)
			$StaticBody2D.set_collision_mask(1792)
	else:
		$StaticBody2D.set_collision_layer(1280)
		$StaticBody2D.set_collision_mask(1280)


func _on_area_entered(area):
	if area.get_parent() is Player:
		drowning = true
		respawntimer = 0


func _on_area_exited(area):
	if area.get_parent() is Player:
		drowning = false
		respawntimer = 0
