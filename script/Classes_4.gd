extends Node


#Священнослужитель kleriker
class Kleriker:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.index = Global.num.index.kleriker
		Global.num.index.kleriker += 1
		obj.tempel = input_.tempel
		#init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.kleriker.instantiate()
		scene.myself.set_parent(self)
		obj.tempel.scene.myself.get_node("Kleriker").add_child(scene.myself)
