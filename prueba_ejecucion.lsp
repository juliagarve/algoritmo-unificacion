(defun llamada (func arg)

	(terpri)
	(princ "Argumento: ")
	(princ arg)
	(terpri)
	(princ "Resultado: ")
	(setf resultado (funcall func arg))
	(princ resultado)
	(terpri)
)

(defun llamada2 (func arg1 arg2)

	(terpri)
	(princ "Argumento1: ")
	(princ arg1)
	(terpri)
	(princ "Argumento2: ")
	(princ arg2)
	(terpri)
	(princ "Resultado: ")
	(setf resultado (funcall func arg1 arg2))
	(princ resultado)
	(terpri)
)

(prog ()
	(load "C:\\Users\\Julia\\Desktop\\julia\\universidad\\5_Curso\\FSI\\algoritmo_unificar.lsp")


	(print "--------------------- Funcion esvar ---------------------")
	(setf func 'esvar)

	(print "----- Prueba 1 -----") 
	(setf var '(? x))
	(llamada func var) 

	(print "----- Prueba 2 -----") 
	(setf var 'A)
	(llamada func var)

	(print "--------------------- Funcion esatomo ---------------------")
	(setf func 'esatomo)

	(print "----- Prueba 1 -----") 
	(setf var '(? x))
	(llamada func var) 

	(print "----- Prueba 2 -----") 
	(setf var 'A)
	(llamada func var)

	(print "----- Prueba 3 -----") 
	(setf var '(P (? x)))
	(llamada func var)

	(print "--------------------- Funcion esmiembro ---------------------")
	(setf func 'esmiembro)

	(print "----- Prueba 1 -----") 
	(setf var1 '(? x))
	(setf var2 '(P (? y) (? x)))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '(? x))
	(setf var2 '(P (? y)))
	(llamada2 func var1 var2)

	(print "--------------------- Funcion aplicar ---------------------")
	(setf func 'aplicar)

	(print "----- Prueba 1 -----") 
	(setf var1 '((A / (? x)) ((? y) / (? z)) ((f (? h))/ (? k))))
	(setf var2 '(P (? x) (g (? k)) (f2 (? z))))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '((A / (? x)) (B / (? k)) ((f3 (? h))/ (? z))))
	(setf var2 '(P (? x) (f (g (? k))) (f2 (? z))))
	(llamada2 func var1 var2) 

	(print "--------------------- Funcion composicion ---------------------")
	(setf func 'composicion)

	(print "----- Prueba 1 -----")
	(setf var1 '((g (? x) (? y)) / (? z)))
	(setf var2 '((A / (? x)) (B / (? y)) (C / (? w)) (D / (? z))))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '(((g (? y) A) / (? x)) (B / (? y)) ((f (? w))/ (? z))))
	(setf var2 '(((f (? b)) / (? y)) ((? u) / (? w)) (C / (? t))))
	(llamada2 func var1 var2)

	(print "--------------------- Funcion unificar ---------------------")
	(setf func 'unificar)

	(print "----- Prueba 1 -----")
	(setf var1 '(P (? x) (? y)))
	(setf var2 '(P (? y) (? x)))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '(P (? x) (g (? z))))
	(setf var2 '(P (g (? y)) (? x)))
	(llamada2 func var1 var2)

	(print "----- Prueba 3 -----") 
	(setf var1 '(P (? x) (? x)))
	(setf var2 '(P A B))
	(llamada2 func var1 var2)
)
