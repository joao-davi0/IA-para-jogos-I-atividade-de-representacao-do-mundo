extends CharacterBody2D

@export var max_health = 100
@export var speed = 235

@onready var world = get_tree().get_first_node_in_group("world")
var health = max_health
var player_in_attack_area = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

func _process(_delta):
	$HealthLabel.text = str(health)
	
	if world.game_started:
		var area = get_parent()
		
		if area.active:
			var player = get_tree().get_first_node_in_group("player")
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO

func take_damage(amount):
	health -= amount

	if health <= 0:
		die()

func die():
	queue_free()

func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_attack_area = true
		$DamageTimer.start()
		
func _on_attack_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_attack_area = false
		$DamageTimer.stop()
		
func _on_damage_timer_timeout():
	if player_in_attack_area:
		var player = get_tree().get_first_node_in_group("player")

		if player:
			player.take_damage(1)
