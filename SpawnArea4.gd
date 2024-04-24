extends Area2D

#var enabled
#var wallcollisioncounter = 0
#signal stateChanged(newState)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func setenabled(newState: bool):
	#if newState == enabled:
		#return
	#enabled = newState
	#emit_signal("stateChanged", enabled)
#
#func _on_area_entered(area):
	#if area.is_in_group("Hitbox"):
		#if area.get_parent().is_in_group("Solid"):
			#wallcollisioncounter -= 1
			#if wallcollisioncounter < 0:
				#setenabled(false)
			##print("spawn 4 disabled")
#
#
#func _on_area_exited(area):
	#if area.is_in_group("Hitbox"):
		#if area.get_parent().is_in_group("Solid"):
			#wallcollisioncounter += 1
			#if wallcollisioncounter == 0:
				#setenabled(true)
			##print("spawn 4 enabled")
#
#
#func _on_state_changed(newState):
	#if newState:
		#get_parent().get_parent().enabledamount += 1
	#else: get_parent().get_parent().enabledamount -= 1
