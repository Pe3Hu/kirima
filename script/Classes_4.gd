extends Node


#Священнослужитель kleriker
class Kleriker:
	var arr = {}
	var obj = {}
	var num = {}
	var word = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.index = Global.num.index.kleriker
		Global.num.index.kleriker += 1
		obj.tempel = input_.tempel
		word.credo = input_.credo
		init_anzeige()
		init_mönch()


	func init_scene() -> void:
		scene.myself = Global.scene.kleriker.instantiate()
		scene.myself.set_parent(self)
		obj.tempel.scene.myself.get_node("Kleriker").add_child(scene.myself)


	func init_anzeige() -> void:
		var input = {}
		input.kleriker = self
		obj.anzeige = Classes_4.Anzeige.new(input)


	func init_credo() -> void:
		word.credo = "jester"#Global.get_random_element(Global.dict.credo.keys())


	func init_mönch() -> void:
		var input = {}
		input.kleriker = self
		obj.mönch = Classes_5.Mönch.new(input)


#Показатель anzeige
class Anzeige:
	var obj = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.kleriker = input_.kleriker
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.anzeige.instantiate()
		scene.myself.set_parent(self)

