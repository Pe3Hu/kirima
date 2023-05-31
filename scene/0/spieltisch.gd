extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	set_spielers()
	update_color()


func set_spielers() -> void:
		for croupier in parent.arr.croupier:
			croupier.obj.spieltisch = parent
			$Croupier.add_child(croupier.scene.myself)


func update_color() -> void:
	var max_h = 360.0
	var h = float(parent.num.index)/Global.num.index.spieltisch
	var s = 0.75
	var v = 1
	
	var color_ = Color.from_hsv(h,s,v)
	$BG.set_color(color_)
