extends Node


var rng = RandomNumberGenerator.new()
var num = {}
var dict = {}
var arr = {}
var obj = {}
var node = {}
var flag = {}
var vec = {}
var scene = {}


func init_num() -> void:
	num.index = {}
	num.index.spieltisch = 0
	num.index.spieler = 0
	num.index.kleriker = 0
	
	num.stat = {}
	num.stat.min = {}
	num.stat.min.rage = 100
	num.stat.min.auxiliary = 100
	
	num.aspect = {}
	num.aspect.group = {}
	num.aspect.group.main = 2
	num.aspect.group.auxiliary = 1
	num.aspect.synergy = {}
	num.aspect.synergy.auxiliary = 0.25
	
	num.separation = {}
	num.separation.croupier = 5
	num.separation.spielkarte = 5
	
	num.spielkarte = {}
	num.spielkarte.rank = {}
	num.spielkarte.rank.max = 7
	num.spielkarte.rank.min = 1
	num.spielkarte.rank.white_skin = num.spielkarte.rank.max * 2 + num.spielkarte.rank.min


func init_dict() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]
	
	init_octagon()
	init_gebet()
	init_scherbe()
	init_etikett()
	init_base_stat()


func init_octagon() -> void:
	dict.octagon = {}
	var path = "res://asset/json/octagon_data.json"
	var array = load_data(path)
	var keys = {}
	keys.word = []
	keys.num = []
	
	for key in array.front().keys():
		if key.to_lower().contains("min") or key.to_lower().contains("max"):
			keys.num.append(key)
		else:
			keys.word.append(key)
			arr[key.to_lower()] = []
	
	var datas = []
	
	for dict_ in array:
		var data = {}
		
		for tag in keys:
			for key in keys[tag]:
				match tag:
					"word":
						data[key.to_lower()] = dict_[key].to_lower()
						
						if !arr[key.to_lower()].has(data[key.to_lower()]):
							arr[key.to_lower()].append(data[key.to_lower()].to_lower())
					"num":
						var edges = key.split(" ")
						var polyhedron = "polyhedron " + str(edges[1].to_lower())
						
						if !data.keys().has(polyhedron):
							data[polyhedron] = {}
						
						data[polyhedron][edges[0].to_lower()] = dict_[key]
		
		datas.append(data)
	
	for data in datas:
		if !dict.octagon.keys().has(data.aspect):
			dict.octagon[data.aspect] = {}
		
		if !dict.octagon[data.aspect].keys().has(data.type):
			dict.octagon[data.aspect][data.type] = {}
		
		if !dict.octagon[data.aspect][data.type].keys().has(data.category):
			dict.octagon[data.aspect][data.type][data.category] = {}
		
		var polyhedron = null
		
		for key in data.keys():
			if key.contains("polyhedron"):
				polyhedron = key
		
		dict.octagon[data.aspect][data.type][data.category] = data[polyhedron]


func init_gebet() -> void:
	dict.gebet = {}
	dict.credo = {}
	dict.gebet.title = {}
	var path = "res://asset/json/gebet_data.json"
	var array = load_data(path)
	
	for gebet in array:
		var data = {}

		for key in gebet.keys():
			#if key != "Title":
			data[key.to_lower()] = gebet[key]
				
			if typeof(gebet[key]) == TYPE_STRING:
				data[key.to_lower()] = gebet[key].to_lower()
			
			if key == "Creed" and !dict.credo.keys().has(gebet[key].to_lower()):
				dict.credo[gebet[key].to_lower()] = []
		
		dict.gebet.title[gebet["Title"].to_lower()] = data


func init_etikett() -> void:
	dict.etikett = {}
	dict.etikett.title = {}
	var path = "res://asset/json/etikett_data.json"
	var array = load_data(path)
	
	for etikett in array:
		var data = {}

		for key in etikett.keys():
			if key == "source":
				data[key] = etikett[key].rsplit(", ")
			else:
				data[key] = etikett[key]
			
			if key == "duplicate change":
				data[key] = data[key].replace('"', "")
		
		dict.etikett.title[etikett["title"]] = data


func init_scherbe() -> void:
	dict.scherbe = {}
	dict.scherbe.aspect = {}
	dict.scherbe.aspect["health"] = "N"
	dict.scherbe.aspect["body"] = "NE"
	dict.scherbe.aspect["rage"] = "E"
	dict.scherbe.aspect["sense"] = "SE"
	dict.scherbe.aspect["power"] = "S"
	dict.scherbe.aspect["mind"] = "SW"
	dict.scherbe.aspect["mana"] = "W"
	dict.scherbe.aspect["spirit"] = "NW"
	dict.scherbe.wind_rose = {}
	
	for aspect in dict.scherbe.aspect:
		var wind_rose = dict.scherbe.aspect[aspect]
		dict.scherbe.wind_rose[wind_rose] = aspect
	
	dict.scherbe.group = {}
	
	for _i in arr.wind_rose.size():
		var _j = (_i+1+arr.wind_rose.size())%arr.wind_rose.size()
		var _l = (_i-1+arr.wind_rose.size())%arr.wind_rose.size()
		var indexs = [_i, _j, _l]
		var key = arr.wind_rose[_i]
		dict.scherbe.group[key] = {}
		
		for index in indexs.size():
			var wind_rose = arr.wind_rose[indexs[index]]
			var aspect = dict.scherbe.wind_rose[wind_rose]
			dict.scherbe.group[key][aspect] = num.aspect.group.auxiliary
		
		var aspect = dict.scherbe.wind_rose[key]
		dict.scherbe.group[key][aspect] += num.aspect.group.main - num.aspect.group.auxiliary
	
	dict.scherbe.polyhedron = {}
	
	for _i in arr.polyhedron.size():
		var polyhedron = arr.polyhedron[_i]
		dict.scherbe.polyhedron[polyhedron] = {}
		dict.scherbe.polyhedron[polyhedron]["min"] = _i
		dict.scherbe.polyhedron[polyhedron]["max"] = 1+_i
		
		if _i == 0:
			dict.scherbe.polyhedron[polyhedron]["min"] += 1
	
	dict.scherbe.auxiliary = {}
	
	for wind_rose in dict.scherbe.group.keys():
		var aspects = {}
		aspects.main = []
		aspects.auxiliary = []
		
		for aspect in dict.scherbe.group[wind_rose]:
			match dict.scherbe.group[wind_rose][aspect]:
				num.aspect.group.main:
					aspects.main.append(aspect)
				num.aspect.group.auxiliary:
					aspects.auxiliary.append(aspect)
		
		var main = aspects.main.front()
		
		if arr.main.has(main):
			dict.scherbe.auxiliary[main] = aspects.auxiliary


func init_base_stat() -> void:
	dict.stat = {}
	dict.stat.base = {}
	dict.stat.base["health"] = 500
	dict.stat.base["body"] = num.stat.min.auxiliary
	dict.stat.base["rage"] = 1000
	dict.stat.base["sense"] = num.stat.min.auxiliary
	dict.stat.base["power"] = 250
	dict.stat.base["mind"] = num.stat.min.auxiliary
	dict.stat.base["mana"] = 100
	dict.stat.base["spirit"] = num.stat.min.auxiliary


func init_arr() -> void:
	arr.sequence = {}
	arr.color = ["Red","Green","Blue","Yellow"]
	arr.wind_rose = ["N","NE","E","SE","S","SW","W","NW"]
	arr.auxiliary = ["body","sense","mind","spirit"]
	arr.main = ["health","rage","power","mana"]
	arr.polyhedron = [3,4,5,6]


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_vec():
	vec.size = {}
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)
	
	#font size 28
	vec.size.spielkarte = Vector2(40, 50)


func init_scene() -> void:
	scene.kasino = load("res://scene/0/kasino.tscn")
	scene.wettbewerb = load("res://scene/0/wettbewerb.tscn")
	scene.spieltisch = load("res://scene/0/spieltisch.tscn")
	scene.spieler = load("res://scene/1/spieler.tscn")
	scene.croupier = load("res://scene/1/croupier.tscn")
	scene.spielkarte = load("res://scene/2/spielkarte.tscn")


func _ready() -> void:
	init_arr()
	init_num()
	init_dict()
	init_node()
	init_vec()
	init_scene()


func get_random_element(arr_: Array):
	if arr_.size() == 0:
		print("!bug! empty array in get_random_element func")
		return null
	
	rng.randomize()
	var index_r = rng.randi_range(0, arr_.size()-1)
	return arr_[index_r]


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null


func save(path_: String, data_: String):
	var path = path_+".json"
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.save(data_)
	file.close()


func load_data(path_: String):
	var file = FileAccess.open(path_,FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()
