extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	update_color()


func update_color() -> void:
	var max_h = 360.0
	var h = float(parent.obj.spieler.num.index)/Global.num.index.spieler
	var s = 0.75
	var v = 1
	var color_ = Color.from_hsv(h,s,v)
	$BG.set_color(color_)


func add_spielkarte_into_thought(spielkarte_):
	$Spielkarte/Thought.add_child(spielkarte_.scene.myself)
	spielkarte_.scene.myself.recolor_bg("default")


func convert_thought_into_dream(spielkarte_):
	$Spielkarte/Thought.remove_child(spielkarte_.scene.myself)
	$Spielkarte/Dream.add_child(spielkarte_.scene.myself)
	
	if $Spielkarte/Thought.get_child_count() == 0:
		$Spielkarte.set("theme_override_constants/separation", 0)
	else:
		$Spielkarte.set("theme_override_constants/separation", Global.num.separation.spielkarte)


func remove_spielkartes_from_dream():
	for child in $Spielkarte/Thought.get_children():
		child.scene.myself.recolor_bg("default")
		$Spielkarte/Thought.remove_child(child)


func recolor_spielkartes_bg(layer_: String) -> void:
	for child in $Spielkarte/Dream.get_children():
		child.recolor_bg(layer_)
