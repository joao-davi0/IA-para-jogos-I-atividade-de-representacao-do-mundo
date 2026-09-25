extends Area2D

@export var heal_amount = 30

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.heal(heal_amount)
		queue_free()
