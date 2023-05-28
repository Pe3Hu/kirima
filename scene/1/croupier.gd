extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func update_rec_size() -> void:
	var x = max($Spielkarte/Thought.get_child_count(), $Spielkarte/Dream.get_child_count())
	var y = 0
	
	for child in $Spielkarte.get_children():
		if child.get_child_count() > 0:
			y += 1
	
	custom_minimum_size = Vector2(x, y)
	custom_minimum_size.x *= Global.vec.size.spielkarte.x
	custom_minimum_size.y *= Global.vec.size.spielkarte.y
	custom_minimum_size.y += $Spielkarte.get("theme_override_constants/separation")
	print(custom_minimum_size)
	parent.obj.spieler.scene.myself.custom_minimum_size = Vector2(custom_minimum_size) * 1.25
	print(parent.obj.spieler.scene.myself.custom_minimum_size)
	#parent.obj.spieler.obj.spieltisch.scene.myself.custom_minimum_size = Vector2(parent.obj.spieler.scene.myself.custom_minimum_size) * 1.25


func add_spielkarte_into_thought(spielkarte_):
	$Spielkarte/Thought.add_child(spielkarte_.scene.myself)
	update_rec_size()


func convert_thought_into_dream(spielkarte_):
	$Spielkarte/Thought.remove_child(spielkarte_.scene.myself)
	$Spielkarte/Dream.add_child(spielkarte_.scene.myself)
	update_rec_size()


func remove_spielkartes_from_dream():
	for child in $Spielkarte/Thought.get_children():
		$Spielkarte/Thought.remove_child(child)
	
	update_rec_size()
