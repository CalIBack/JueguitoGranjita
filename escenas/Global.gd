extends Node

var maximo1 = 0
var maximo2 = 0

func guardar():
	var archivo = FileAccess.open("user://guardado.dat", FileAccess.WRITE)
	archivo.store_var(maximo1)
	archivo.store_var(maximo2)
	archivo.close()

func cargar():
	if FileAccess.file_exists("user://guardado.dat"):
		var archivo = FileAccess.open("user://guardado.dat", FileAccess.READ)
		maximo1 = archivo.get_var()
		maximo2 = archivo.get_var()
		archivo.close()
