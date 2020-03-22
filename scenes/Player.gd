extends Node2D

export var speed: int = 400

var screen_size
var animation = "idle"

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if event is InputEventKey:
		animation = "idle"
		if event.scancode == KEY_X:     animation = "attack"

func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"): velocity.x += .8
	if Input.is_action_pressed("ui_left"):  velocity.x -= .8
	if Input.is_action_pressed("ui_down"):  velocity.y += .6
	if Input.is_action_pressed("ui_up"):    velocity.y -= .6
	
	if velocity.length() > 0:
		velocity = velocity * speed
		$Animation.flip_h = velocity.x < 0
		animation = "run"
		
	$Animation.play(animation)
	$Animation.z_index = position.y
	
	position += velocity * delta
	position.x = clamp(position.x, 5, 2525)
	position.y = clamp(position.y, 330, 615)
