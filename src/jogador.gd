extends CharacterBody2D

@export var speed = 400
@export var max_health = 100

@onready var world = get_tree().get_first_node_in_group("world")
var health = max_health
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = Vector2(3455, 3455)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if world.game_started:
		var direction = Input.get_vector(
			"mover_esquerda",
			"mover_direita",
			"mover_cima",
			"mover_baixo"
		)
		
		velocity = direction * speed
		move_and_slide()

		if velocity.length() > 0:
			#velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()

		position = position.clamp(Vector2.ZERO, screen_size)
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0

func take_damage(amount):
	health -= amount

	if health <= 0:
		die()
		
func heal(amount):
	health += amount

	if health > max_health:
		health = max_health

func die():
	world.end_game()

	queue_free()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
