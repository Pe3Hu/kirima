extends Node


#Игровой стол spieltisch
class Spieltisch:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_) -> void:
		num.index = Global.num.index.spieltisch
		Global.num.index.spieltisch += 1
		obj.kasino = input_.kasino
		arr.spieler = input_.spielers
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.spieltisch.instantiate()
		scene.myself.set_parent(self)
		obj.kasino.scene.myself.get_node("Spieltisch").add_child(scene.myself)


#Казино kasino
class Kasino:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init() -> void:
		init_scene()
		init_spielers()
		init_spieltisch()


	func init_scene() -> void:
		scene.myself = Global.scene.kasino.instantiate()
		Global.node.game.get_node("Layer0").add_child(scene.myself)


	func init_spieltisch() -> void:
		var input = {}
		input.kasino = self
		input.spielers = [arr.spieler.front(),arr.spieler.back()]
		obj.spieltisch = Classes_0.Spieltisch.new(input)


	func init_spielers() -> void:
		arr.spieler = []
		var n = 2
		
		for _i in n:
			var input = {}
			input.kasino = self
			var spieler = Classes_1.Spieler.new(input)
			arr.spieler.append(spieler)
