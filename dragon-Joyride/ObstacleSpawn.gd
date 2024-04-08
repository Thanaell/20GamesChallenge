extends Node2D
var speed = 1

func onTimerExpired():
	var bee = preload("res://bee.tscn")
	var spike = preload("res://spike.tscn")

	var rng = RandomNumberGenerator.new()
	var value = rng.randi_range(0,5)
	
	match value:
		1:
			var bee1 = bee.instantiate()
			add_child(bee1)
			bee1.position=$BeesSpawnPoint1.position
		2:
			var bee2 = bee.instantiate()
			bee2.position=$BeesSpawnPoint2.position
			add_child(bee2)
		3: 
			var spike1 = spike.instantiate()
			spike1.position=$SpikesSpawnPoint.position
			add_child(spike1)
		_:
			pass
			
