extends Node


#Кардинал kardinal
class Kardinal:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.tempel = input_.tempel
		arr.challenger = []


	func set_challengers() -> void:
		for kleriker in obj.tempel.arr.kleriker:
			arr.challenger.append(kleriker)


#Храм tempel
class Tempel:
	var arr = {}
	var obj = {}
	var dict = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.glaube = input_.glaube
		init_kardinal()
		init_klerikers()
		set_basic_scherbes()
		suit_up_basic_scherbes()
		obj.kardinal.set_challengers()


	func init_kardinal() -> void:
		var input = {}
		input.tempel = self
		obj.kardinal = Classes_3.Kardinal.new(input)


	func init_klerikers() -> void:
		arr.kleriker = []
		var n = 1
		
		for credo in Global.dict.credo.keys():
			var input = {}
			input.tempel = self
			input.credo = credo
			var kleriker = Classes_4.Kleriker.new(input)
			arr.kleriker.append(kleriker)


	func set_basic_scherbes() -> void:
		dict.scherbe = {}
		
		for wind_rose in Global.arr.wind_rose:
			dict.scherbe[wind_rose] = []
		
		for _i in arr.kleriker.size()+1:
			for wind_rose in Global.arr.wind_rose:
				var input = {}
				input.wind_rose = wind_rose
				input.polyhedron = 3
				var scherbe = Classes_5.Scherbe.new(input)
				dict.scherbe[wind_rose].append(scherbe)


	func suit_up_basic_scherbes() -> void:
		for kleriker in arr.kleriker:
			kleriker.obj.mönch.choose_best_outfit()


#Вера glaube
class Glaube:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init() -> void:
		#init_scene()
		init_tempels()


	func init_scene() -> void:
		scene.myself = Global.scene.tempel.instantiate()
		Global.node.game.get_node("Layer1").add_child(scene.myself)


	func init_tempels() -> void:
		arr.tempel = []
		var n = 2
		
		for _i in n:
			var input = {}
			input.glaube = self
			var tempel = Classes_3.Tempel.new(input)
			arr.tempel.append(tempel)
