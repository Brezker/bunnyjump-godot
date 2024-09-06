extends Area2D
class_name Platform

func _on_body_entered(body):
	if body is Player:
		#print('Player Hited!')
		if body.velocity.y > 0:
			body.jump()
