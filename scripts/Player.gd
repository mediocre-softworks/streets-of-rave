extends Node2D

export var speed = 400
var screen_size
var kick_timeout: int = 0
var delta_time: float = 0
var rng = RandomNumberGenerator.new()


func _ready():
	screen_size = get_viewport_rect().size
	rng.randomize()


func _input(event):
	var s = get_node_or_null("Player/Sprite")
	if s:
		if event is InputEventKey:
			if event.scancode == KEY_SPACE:
				kick_timeout = 3


func _process(delta):
	var velocity = Vector2()

	if Input.is_action_pressed("ui_right"): velocity.x += 1
	if Input.is_action_pressed("ui_left"):  velocity.x -= 1
	if Input.is_action_pressed("ui_down"):  velocity.y += 1
	if Input.is_action_pressed("ui_up"):    velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	delta_time += delta
	
	var s = get_node_or_null("Player/Sprite")
	if s:
		s.flip_h = velocity.x < 0
		s.flip_v = kick_timeout > 0

		if kick_timeout > 0:
			kick_timeout -= 1
		
		if velocity.length():
			s.rotate(clamp(abs(cos(delta_time)), 0, 0.05))
			if s.rotation > 0.3:
				s.rotate(-s.rotation)
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	

