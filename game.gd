extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_warrior_spawn_pressed():
	add_child(load("res://warrior.tscn").instantiate())


func _on_archer_spawn_pressed():
	add_child(load("res://archer.tscn").instantiate())


func _on_pyro_spawn_pressed():
	add_child(load("res://pyromancer.tscn").instantiate())


func _on_knight_spawn_pressed():
	add_child(load("res://knight.tscn").instantiate())
