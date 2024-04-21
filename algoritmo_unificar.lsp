(defun unificar 
	(e1 e2)

	(when (or (esatomo e1) (esatomo e2)) 
		(when (not (esatomo e1))
			(setf temp e1 e1 e2 e2 temp)
		)
	)
	(when (esatomo e1) 
		(cond	((equalp e1 e2) (return-from unificar NIL))
			((and (esvar e1) (esmiembro e1 e2)) (return-from unificar 'FALLO))
			((and (esvar e1) (not (esmiembro e1 e2))) (return-from unificar (list e2 '/ e1)))
			((esvar e2) (return-from unificar (list e1 '/ e2)))
			( t (return-from unificar 'FALLO))
		)
	)

	(setf f1 (first e1) t1 (rest e1))
	(setf f2 (first e2) t2 (rest e2))
	(setf variables (list t1 t2))

	(if (boundp 'aux3) ;Si aux3 esta definida
		(setf aux3 (append aux3 (list variables)) z1 (unificar f1 f2) variables (first (last aux3)) aux3 (butlast aux3))
		(setf aux3 (list variables) z1 (unificar f1 f2) variables (first (last aux3)) aux3 (butlast aux3))
	)
	
	(setf t1 (first variables))
	(setf t2 (first (last variables)))

	(setf z1 (unificar f1 f2))
	
	(when (equalp z1 'FALLO) (return-from unificar 'FALLO)) 

	(setf g1 (aplicar z1 t1))

	(setf g2 (aplicar z1 t2))

	(if (boundp 'aux4) ;Si aux4 esta definida
		(setf aux4 (append aux4 (list z1)) z2 (unificar g1 g2) z1 (first (last aux4)) aux4 (butlast aux4))
		(setf aux4 (list z1) z2 (unificar g1 g2) z1 (first (last aux4)) aux4 (butlast aux4))
	)

	(when (equalp z2 'FALLO) (return-from unificar 'FALLO))

	(setf ret (composicion z1 z2))

	(return-from unificar ret)
)

(defun esvar
	(var)
	(cond	((atom var) NIL)
		((eq (first var) '?) T)
		(T NIL)
	)
)

(defun esatomo
	(var)
	(cond	((atom var) T)
		((eq (first var) '?) T)
		(T NIL)
	)
)

(defun esmiembro
	(var1 var2)
	(unless (atom var2) 
		(if (member var1 var2 :test 'equal)
			(return-from esmiembro T)
			(return-from esmiembro NIL)
		)
	)
)

(defun aplicar 
	(expresion sentencia)
	(when (boundp 'aux2)
		(makunbound 'aux2)
	)
	(if (member '/ expresion)
		(aplicar_una expresion sentencia)
		(dolist (cambio expresion sentencia) ; Varias sustituciones
			(setf sentencia (aplicar_una cambio sentencia))
		)
	)
)

(defun aplicar_una
	(expresion sentencia)

	(cond	((or (null expresion) (esatomo expresion)) sentencia)
		((null sentencia) sentencia)
	)
	(when (esatomo sentencia)
		(if (equalP sentencia (first  (last (member '/ expresion))))
			(setf sentencia (first expresion))
		)
		(return-from aplicar_una sentencia)
	)

	(setf sentencia_cambiada NIL)
	
	;(first  (last (member '/ expresion))) --> lo que hay que buscar y cambiar
	;(first	expresion) ----> con lo que hay que cambiarlo

	(dolist (elemento sentencia sentencia_cambiada)
		(if (esatomo elemento)
			(when (equalP elemento (first  (last (member '/ expresion))))
				(setf elemento (first expresion))
			)
			(if (equalP elemento (first  (last (member '/ expresion))))
				(setf elemento (first expresion))
				(if (boundp 'aux2) ;Si aux2 esta definida
					(setf aux2 (append aux2 (list sentencia_cambiada)) elemento (aplicar_una expresion elemento) sentencia_cambiada (first (last aux2)) aux2 (butlast aux2))
					(setf aux2 (list sentencia_cambiada) elemento (aplicar_una expresion elemento) sentencia_cambiada (first (last aux2)) aux2 (butlast aux2))
				)
			) 
		)

		(setf elemento (list elemento))
		(if (null sentencia_cambiada)
			(setf sentencia_cambiada elemento) ;primer elemento
			(setf sentencia_cambiada (append sentencia_cambiada elemento))
		)

	)	
	
	(setf sentencia_cambiada sentencia_cambiada) ; para devolver esto 
)

(defun composicion
	(expresion1 expresion2)

	(if (member '/ expresion2)
		(setf expresion1 (composicion_una expresion1 expresion2 '0))
		(dolist (cambio expresion2 expresion1) ; Varias sustituciones
			(setf expresion1 (composicion_una expresion1 cambio '0))
		)
	)

	; Lo de a continuacion para añadir terminos faltantes a la composicion

	(if (member '/ expresion1)
		(setf primero T)
		(setf primero NIL)
	)
	(if (member '/ expresion2)
		(setf expresion1 (comprobar_existencia expresion1 expresion2 primero))
		(dolist (cambio expresion2 expresion_final) ; Varias sustituciones
			(setf expresion1_act (comprobar_existencia expresion1 cambio primero))
			(when primero 
				(unless (equalp expresion1_act expresion1)
					(setf primero NIL)
				)
			)
			(setf expresion1 expresion1_act)
		)
	)
	(setf expresion1 expresion1)
	
)

(defun comprobar_existencia
	(expresion1 expresion2 primero)
	(setf existencia NIL)
	(if (member '/ expresion1)
		(setf existencia (equalp (first (last expresion2)) (first (last expresion1))))
		(dolist (cambio expresion1 expresion_final) ; Varias sustituciones
			(if (not existencia) 
				(when (equalp (first (last expresion2)) (first (last cambio)))
					(setf existencia T)
				)
			)
		)
	)

	(if (not existencia)
		(if primero
			(setf expresion_final (append (list expresion1) (list expresion2)))
			(setf expresion_final (append expresion1 (list expresion2)))
		) 
		(setf expresion_final expresion1)
	)
)

(defun composicion_una
	(expresion1 expresion2 aux)

	(cond	((or (null expresion1) (atom expresion1)) expresion1)
		((null expresion2) expresion1)
	)
	(setf flag NIL)
	(when (equalp aux '0) (setf expresion1_cambiada NIL))
	(if (member '/ expresion1) ;Solo un elemento (ej: {g(x,y)/z})
		;(first	expresion1) ----> lo que hay que cambiar
		(setf resultado (append (append (aplicar_una expresion2 (list (first expresion1))) (list '/)) (last (member '/ expresion1))) flag T)
		(dolist (sentencia_a_cambiar expresion1 expresion1_cambiada) ;Varios elementos ({g(x,y)/z, f(h)/k})
			
			(setf sentencia_cambiada (composicion_una sentencia_a_cambiar expresion2 '1))
			(if (null expresion1_cambiada)
				(setf expresion1_cambiada (list sentencia_cambiada)) ;primer elemento
				(setf expresion1_cambiada (append expresion1_cambiada (list sentencia_cambiada)))
			)
		)
	)
	(if flag
		(setf resultado resultado flag NIL)
		(setf resultado expresion1_cambiada)
	)
	(setf resultado resultado)
)