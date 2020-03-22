extends Node2D


func _ready():
	$Animation.play("idle")
	$Animation.z_index = position.y
