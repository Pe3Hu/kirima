extends Node


#Игровой стол spieltisch
class Spieltisch:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.index = Global.num.index.spieltisch
		Global.num.index.spieltisch += 1
		obj.kasino = input_.kasino
		arr.croupier = input_.croupiers
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
		init_spieltischs()


	func init_scene() -> void:
		scene.myself = Global.scene.kasino.instantiate()
		Global.node.game.get_node("Layer0").add_child(scene.myself)


	func init_spieltischs() -> void:
		arr.spieltisch = []
		var input = {}
		input.kasino = self
		input.croupiers = [arr.spieler.front().obj.croupier,arr.spieler.back().obj.croupier]
		var spieltisch = Classes_0.Spieltisch.new(input)
		arr.spieltisch.append(spieltisch)


	func init_spielers() -> void:
		arr.spieler = []
		var n = 2
		
		for _i in n:
			var input = {}
			input.kasino = self
			var spieler = Classes_1.Spieler.new(input)
			arr.spieler.append(spieler)
