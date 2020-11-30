extends Node2D

export var speed: int = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_X:
			pass

func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"): velocity.x += 1
	if Input.is_action_pressed("ui_left"):  velocity.x -= 1
	if Input.is_action_pressed("ui_down"):  velocity.y += 1
	if Input.is_action_pressed("ui_up"):    velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity * speed
		#$Sprite.flip_h = velocity.x < 0
		$Animations.play("Run")
		$Frames.play("Run")
	else:
		$Animations.play("Idle")
		$Frames.play("Idle")
	
	position += velocity * delta
