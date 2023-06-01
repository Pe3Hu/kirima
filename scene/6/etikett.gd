extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	custom_minimum_size = Global.vec.size.node.etikett
	update_color()
	set_labels()


func update_color() -> void:
	var max_h = 360.0
	var h = 0
	var s = 0.75
	var v = 1
	var source = Global.dict.etikett.title[parent.word.title].source[0]
	
	match source:
		"water":
			h = 220.0
		"ice":
			h = 180.0
		"air":
			h = 150.0
		"lightning":
			h = 270.0
		"fire":
			h = 0.0
		"lava":
			h = 320.0
		"earth":
			h = 45.0
		"nature":
			h = 100.0
	
	h /= max_h
	var color_ = Color.from_hsv(h, s, v)
	$BG.set_color(color_)


func set_labels() -> void:
	for node in $Label.get_children():
		node.set("theme_override_font_sizes/font_size", Global.num.size.font.etikett)
		
		match node.name:
			"Title":
				var words = parent.word.title.split(" ")
				
				for word in words:
					if word != "of":
						node.text += word[0].to_upper()
			"Counter":
				node.text = str(parent.num.counter)


func add_to_abroller() -> void:
	var abroller = parent.obj.spielkarte.obj.spieler.obj.croupier.obj.spieltisch.obj.abroller
	abroller.scene.myself.get_node("Etikett").add_child(self)
	abroller.scene.myself.set_grid_cols()
