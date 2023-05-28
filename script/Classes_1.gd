extends Node


#Крупье croupier
class Croupier:
	var num = {}
	var obj = {}
	var dict = {}
	var scene = {}


	func _init(input_) -> void:
		num.draw = {}
		num.draw.total = 2
		num.draw.current = num.draw.total
		obj.spieler = input_.spieler
		init_scene()
		init_album()
		
		obj.album.fill_thought()


	func init_scene() -> void:
		scene.myself = Global.scene.croupier.instantiate()
		scene.myself.set_parent(self)
		obj.spieler.scene.myself.get_node("Croupier").add_child(scene.myself)


	func init_album() -> void:
		var input = {}
		input.croupier = self
		obj.album = Classes_2.Album.new(input)



#Игрок spieler
class Spieler:
	var arr = {}
	var num = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		num.index = Global.num.index.spieler
		Global.num.index.spieler += 1
		obj.kasino = input_.kasino
		obj.spieltisch = null
		init_scene()
		init_croupier()


	func init_scene() -> void:
		scene.myself = Global.scene.spieler.instantiate()
		scene.myself.set_parent(self)


	func init_croupier() -> void:
		var input = {}
		input.draw = 5
		input.spieler = self
		obj.croupier = Classes_1.Croupier.new(input)
