README PROYECTO 2

A continuación se enunciarán las características más relevantes del proyecto:

- Para empezar tenemos los siguientes archivos:
	fssh: contiene el main y el prompt.
	comandos: contiene todas las funciones implementadas para la ejecucion de los comandos.

- Se creo un prompt denominado como la raíz introducida por el usuario.

- Se implemento un shell que permite realiza sobre los directorios, algunas operaciones básicas 
sobre los archivos allí contenidos.

- Se creo un proceso por cada uno de los subdirectorios dentro de la jerarquía dada.

- El shell sólo puede ejecutar una orden a la vez.

- No se reconoce ni maneja las redirecciones.

- Las órdenes que el shell podrá reconocer deben ser implementadas como comando internos.

- Los comando a reconocer:
	ls <path>
	cat <path>
	cp <path1> <path2>
	mv <path1> <path2>
	find <cadena>
	rm <path1>
	mkdir <path1>
	rmdir <path1>
	quit

- Contiene los mensajes de error según el tipo de error detectado.

- El comando quit es la única orma de salir del sistema, la combinación de teclas ctrl-c y ctrl-z no deben 
cerrar el shell. Además se imprime un mensaje al usuario sobre la imposibilidad de terminar su shell con 
ctrl-c o ctrl-z.
	
	

