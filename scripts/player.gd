extends CharacterBody2D
class_name Player
@onready var animator = $AnimationPlayer
var speed = 300.0
var gravity = 15.0
var max_full_velocity = 1000.0
var jump_velocity = -800.0
var viewport_size

func _ready():
	viewport_size = get_viewport_rect().size
	
func _process(_delta):
	var current_animation = animator.current_animation
	#print("velocity.y:", velocity.y)
	#print("current_animation:", current_animation)
	if velocity.y > 0:
		if animator.current_animation != "fall":
			animator.play("fall")
			#print("anim fall")
	elif velocity.y < 0:
		if animator.current_animation != "jump":
			animator.play("jump")
			#print("anim jump")

func _physics_process(_delta):
	# Gravedad
	velocity.y += gravity
	if velocity.y > max_full_velocity:
		velocity.y = max_full_velocity
	#print(velocity)
	# Movement
	var direction = Input.get_axis("move_left", "move_right")
	#print(direction)
	if direction:
		velocity.x = direction * speed
	else:
		# Mueve el personaje con retardo segun el "/10" puede ser modificado para cambiar el game-feel
		velocity.x = move_toward(velocity.x, 0, speed/10)
	move_and_slide()
	#print(viewport_size)
	# Teletransporta al jugador si sale de pantalla al otro lado
	var margin = 20
	if global_position.x > viewport_size.x + margin:
		global_position.x = -margin
	if global_position.x < -margin:
		global_position.x = viewport_size.x + margin

func jump():
	velocity.y = jump_velocity
