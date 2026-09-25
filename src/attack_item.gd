extends Area2D

@export var damage = 50
@export var visual_effect_radius := 250

func _ready():
	var points = PackedVector2Array()
	$RangeVisual.hide()
	
	for i in range (32):
		var angle = TAU * i / 32.0
		var point = Vector2(cos(angle), sin(angle)) * visual_effect_radius
		points.append(point)
		
	$RangeVisual.polygon = points

func _on_body_entered(body):
	if body.is_in_group("player"):
		attack_nearby_enemies()
		$Sprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		$RangeVisual.show()
		await get_tree().create_timer(0.4).timeout
		queue_free()

func attack_nearby_enemies():
	var bodies = $DamageArea.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("enemy"):
			body.take_damage(damage)
