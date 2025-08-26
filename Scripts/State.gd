extends Node
class_name State


var player

func _init(_player):
	player = _player

#animation setup, sound effects, timers, logging/debugging
func enter(): pass
#stopping effects, cancelling animations, resetting flags
func exit(): pass
func physics_process(delta): pass
func handle_input(event): pass
