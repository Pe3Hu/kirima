extends Node


#Кардинал kardinal
class Kardinal:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.tempel = input_.tempel


#Храм tempel
class Tempel:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.glaube = input_.glaube
		#init_scene()
		init_klerikers()


	func init_scene() -> void:
		scene.myself = Global.scene.tempel.instantiate()
		obj.glaube.scene.myself.get_node("Kleriker").add_child(scene.myself)


	func init_kardinal() -> void:
		var input = {}
		input.tempel = self
		obj.kleriker = Classes_3.Kardinal.new(input)


	func init_klerikers() -> void:
		arr.kleriker = []
		var n = 1
		
		for _i in n:
			var input = {}
			input.tempel = self
			var kleriker = Classes_4.Kleriker.new(input)
			arr.kleriker.append(kleriker)


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

 
