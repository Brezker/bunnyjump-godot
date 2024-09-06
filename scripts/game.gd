extends Node2D

@onready var level_generator = $LevelGenerator
@onready var groud_sprite = $GroundSprite

var player_scene = preload("res://scenes/player.tscn")
var player = null
var player_spawn_pos: Vector2

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera = null

func _ready():
	var viewport_size = get_viewport_rect().size
	
	var player_spawn_pos_y_offset = 135
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_pos_y_offset
	
	groud_sprite.global_position.x = viewport_size.x / 2.0
	groud_sprite.global_position.y = viewport_size.y
	
	_new_game()
	
	if player:
		level_generator.setup(player)
	
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
func _new_game():
	player = player_scene.instantiate()
	player.global_position = player_spawn_pos
	add_child(player)
	
	camera = camera_scene.instantiate()
	camera.setup_camera(player)
	add_child(camera)
