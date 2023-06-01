extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	set_borders()


func set_borders() -> void:
	var width = 1
	var paths = ["fill", "background"]
	var borders = {}
	borders["Health"] = ["top", "left", "bottom", "right"]
	borders["Mana"] = ["top", "bottom"]
	borders["Rage"] = ["top", "left", "bottom", "right"]
	
	for bar in $Bar.get_children():
		for path in paths:
			var style = bar.get("theme_override_styles/" + path)
			style.set("border_color", Color.BLACK)
			
			for border in borders[bar.name]:
				style.set("border_width_" + border, width)


func update_bar_value(aspect_: String, path_: String) -> void:
	var aspect = aspect_.capitalize()
	var bar = $Bar.get_node(aspect)
	var achteck = parent.obj.kleriker.obj.mönch.obj.achteck
	
	match path_:
		"result":
			bar.max_value = achteck.num.aspect[aspect_][path_]
		"current":
			bar.value = achteck.num.aspect[aspect_][path_]


func reset_aspects() -> void:
	var achteck = parent.obj.kleriker.obj.mönch.obj.achteck
	var paths = ["result", "current"]
	
	for bar in $Bar.get_children():
		var aspect = bar.name.to_lower()
		achteck.num.aspect[aspect].current = achteck.num.aspect[aspect].result
		
		if aspect == "rage":
			achteck.num.aspect[aspect].current = 0
		
		for path in paths:
			update_bar_value(aspect, path)
			var hp = get_hp()
			print(hp)


func get_hp() -> int:
	var bar = $Bar.get_node("Health")
	return bar.value
