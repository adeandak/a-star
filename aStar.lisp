(setq abierto '(edoInicial) cerrado '() edoFinal '((1 2 3)(4 0 5)(6 7 8)))
(setq solucion '())
(setq movsDisp '(-2 -1 1 2))
(setq id 1)
(defun astarPuzzle8 (abierto cerrado edoFinal)
    (let mejorNodo (car abierto))
    (cond 
        ((null mejorNodo) 
            (print 'NO_HAY_SOLUCION))
        ((equal (car (cddddr mejorNodo)) edoFinal) 
            (setq solucion (append solucion (list (list (cadddr mejorNodo) (cadr mejorNodo))))) (backtrack (reverse cerrado)))
        ((previo (car (cddddr mejorNodo) (cdr cerrado))) 
            (setq abierto (cdr abierto)) 
            (astarPuzzle8 abierto cerrado edoFinal))
        (t (generaHijos mejorNodo) 
            (setq cerrado (append cerrado (list mejorNodo)) abierto (cdr abierto)) 
            (sort abierto #'< :key #'third) 
            (astarPuzzle8 abierto cerrado edoFinal))))

;dado un nodo se generan sus hijos y se agregan a abierto
(defun generaHijos (nodo)
    ;revisa cuantos hijos puede generar y checa eso 
    )

;generar un nodo de la forma: nodo=(ID padre f(x) movimiento (estado))
(defun generaNodo (edo mov)
    ;arma que el nodo sea justo dde la forma especifica y le mete todo lo que se necesita
)


;dado un edo y un mov te dice si esta prohibido ese movimiento 
(defun movProhib (edo mov)
    (cond
    ((eql mov 1) (miembro 0 (list (caar edo) (cadar edo) (caddar edo))))
    ((eql mov -1) (miembro 0 (list (caaddr edo) (car (cdaddr edo))(cadr (cdaddr edo)) )))
    ((eql mov 2)(miembro 0 (list (caddar edo) (car (cddadr edo))  (cadr (cdaddr edo)) )))
    ((eql mov -2)(miembro 0 (list (caar edo) (caadr edo) (caaddr edo))))))

;recorre cerrado para obtener el conjunto de movimientos que llevan del estado inicial al estado final
(defun backtrack (lst)
    (cond
        ((null lst) (print solucion))
        ((eql (caar lst) (cadar (reverse solucion))) (setq solucion (append solucion (list (list (cadddr (car lst)) (cadr (car lst)))))) (backtrack (cdr lst)))
        (t (backtrack (cdr lst)))))

;regresa T si el estado pertenece al lst de nodos
(defun previo (estado lst)
    (setq nodo (car lst))
    (cond 
        ((null nodo) nil)
        ((equal estado (car (cddddr nodo))))
        (t (previo estado (cdr lst)))))

nodo=(ID padre f(x) movimiento (estado))



solucion=((mov padre) (mov padre) ...)

(defun miembro (obj lst)
    (cond
        ((null lst) nil)
        ((equal obj (car lst)) t)
        (t (miembro obj (cdr lst)))))

;edo ((1 2 3) (4 5 6) (7 8 9))
#1 caar
#2 cadar
#3 caddar
#4 caadr
#5 cadadr
#6 (car (cddadr edo))
#7 caaddr
#8  (car (cdaddr edo))
#9  (cadr (cdaddr edo))


;movimientos:
;    1=sube al cero (1 2 3)
;    -1=baja al cero (7 8 9)
;    2=mueve a la derecha al cero (3 6 9)
;    -2=mueve a la no derehca al cero (1 4 7)
;

(setq pos '(0 0))
(defun findIJ (pos edo)
    (cond   
        ((or (null pos) (null edo)))
        ((listp (car edo)) (incf (car pos)) (if (miembro 0 (car edo))
        (findIJ (cdr pos) (car edo))
        (findIJ pos (cdr edo))))
        ((eql 0 (car edo)) (incf (car pos)))
        (t (incf (car pos)) (findIJ pos (cdr edo)))))

