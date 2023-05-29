extends Node


#Осколок scherbe
class Scherbe:
	var arr = {}
	var num = {}
	var obj = {}
	var word = {}
	var dict = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.polyhedron = input_.polyhedron
		word.wind_rose = input_.wind_rose
		obj.mönch = null
		init_stat()
		#init_scene()


	func init_stat() -> void:
		dict.stat = {}
		var category = {}
		category.primary = 1
		var limit = Global.dict.scherbe.polyhedron[num.polyhedron]
		Global.rng.randomize()
		category.secondary = Global.rng.randi_range(limit.min, limit.max)
		
		for key in category.keys():
			for _i in category[key]:
				roll_stat(key)


	func roll_stat(category_: String) -> void:
		var aspects = {}
		var types = []
		
		match category_:
			"primary":
				types = ["bonus"]
				aspects = Global.dict.scherbe.group[word.wind_rose]
			"secondary":
				types = Global.arr.type
				
				for aspect in Global.arr.aspect:
					aspects[aspect] = 1
		
		var datas = {}
		
		for aspect in aspects.keys():
			for type in types:
				var data = {}
				data.aspect = aspect
				data.type = type
				var flag = true
				
				if dict.stat.has(aspect):
					if dict.stat[aspect].has(type):
						flag = false
				
				if flag:
					datas[data] = aspects[aspect]
		
		var data = Global.get_random_key(datas)
		
		if !dict.stat.keys().has(data.aspect):
			dict.stat[data.aspect] = {}
		
		dict.stat[data.aspect][data.type] = {}
		var limit = Global.dict.octagon[data.aspect][data.type][category_]
		Global.rng.randomize()
		var value = null
		
		match data.type:
			"bonus":
				value = Global.rng.randi_range(limit.min, limit.max)
			"multiplier":
				value = Global.rng.randi_range(limit.min * 10, limit.max * 10)
				value = float(value)/10.0
				
		dict.stat[data.aspect][data.type][category_] = value


	func init_scene() -> void:
		scene.myself = Global.scene.kleriker.instantiate()
		scene.myself.set_parent(self)
		obj.tempel.scene.myself.get_node("Kleriker").add_child(scene.myself)


#Восьмиугольник achteck 
class Achteck:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.mönch = input_.mönch
		#init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.kleriker.instantiate()
		scene.myself.set_parent(self)
		obj.tempel.scene.myself.get_node("Kleriker").add_child(scene.myself)


#Монах mönch 
class Mönch:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.kleriker = input_.kleriker
		init_kardinal()
		#init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.kleriker.instantiate()
		scene.myself.set_parent(self)
		obj.kleriker.scene.myself.get_node("Kleriker").add_child(scene.myself)


	func init_kardinal() -> void:
		var input = {}
		input.mönch = self
		obj.achteck = Classes_5.Achteck.new(input)
