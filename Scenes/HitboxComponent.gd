extends Area3D
class_name HitboxComponent
@export var health_component: HealthComponent

@onready var knockbackPower = 50
func damage(attack: Attack):	
	if health_component:
		health_component.damage(attack)