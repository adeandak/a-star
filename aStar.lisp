;Proyecto A* Puzzle-8

;------- ESTRUCTURAS DE DATOS ------
;nodo=(ID padre f(x) g(x) movimiento (estado))

;movs=((1 0) (-1 0) (0 1) (0 -1))
;        1      2     3      4

;solucion=((mov padre (edo)) (mov padre (edo)) ...)

;------- INICIAN FUNCIONES --------
(defun astarPuzzle8 ()
    (setf mejorNodo (pop abierto))
    (cond 
        ((or (null mejorNodo) (> id limIt)) 
            (print 'NO_HAY_SOLUCION))
        ((equal (cadr (cddddr mejorNodo)) edoFinal) 
            (setq solucion (append solucion (list (list (car (cddddr mejorNodo)) (cadr mejorNodo) (cadr (cddddr mejorNodo)))))) (backtrack cerrado))
        ((previo (cadr (cddddr mejorNodo)) (cdr cerrado)) 
            (astarPuzzle8))
        (t (generaHijos mejorNodo movs) 
            (push mejorNodo cerrado) 
            (sort abierto #'< :key #'third)
            (if (> (length abierto) limEx) (setq abierto (reverse (nthcdr (- (length abierto) limEx) (reverse abierto)))))
            (astarPuzzle8))))

;dado un nodo se generan sus hijos y se agregan a abierto
(defun generaHijos (nodo movs)
    (cond 
        ((null movs))
        ((= (- 5 (length movs)) (if (evenp (nth 4 nodo)) (- (nth 4 nodo) 1) (+ (nth 4 nodo) 1))) (generaHijos nodo (cdr movs)))
        (t (let* ((edoP (cadr (cddddr nodo)))(edoH (generaEdo edoP (car movs)))(nodoH)(g (+ (nth 3 nodo) 1)))
                (cond
                    ((null edoH))
                    (t (setf nodoH (list (+ id 1) (car nodo) (+ g (costoH edoH 0 0)) g (- 5 (length movs)) edoH)) (incf id) (push nodoH abierto))))
            (generaHijos nodo (cdr movs)))))

;calcula el costo heuristico de un estado
(defun costoH (edo num h)
    (cond
    ((>= num 9) h)
    (t (let* (
        (posNum (findPos num (copy-tree '(0 0)) edo))
        (posF (nth num posFs))
        (dist (+ (abs (- (car posNum) (car posF))) (abs (- (cadr posNum) (cadr posF))))))
        (costoH edo (+ num 1) (+ h dist))))))

;encuentra las coordenadas de num en edo
(defun findPos (num pos edo)
    (cond   
        ((or (null pos) (null edo)))
        ((listp (car edo)) (incf (car pos)) (if (miembro num (car edo))
            (findPos num (cdr pos) (car edo))
            (findPos num pos (cdr edo))))
        ((eql num (car edo)) (incf (car pos)))
        (t (incf (car pos)) (findPos num pos (cdr edo))))
        pos)

;genera un estado dado el padre y el mov a realizar, regresa nil si no es valido el mov
(defun generaEdo (edoP mov &aux posA posD)
    (setq edo (copy-tree edoP))
    (let* ((d0 (copy-tree '(0 0)))(posA (findij d0 edo))(posD (list (+ (car posA) (car mov)) (+ (cadr posA) (cadr mov)))))
    (cond
        ((and (>= 3 (car posD) 1) (>= 3 (cadr posD) 1))(swap edo posA posD))
        (t nil))))

;recorre cerrado para obtener el conjunto de movimientos que llevan del estado inicial al estado final
(defun backtrack (lst)
    (cond
        ((null lst) solucion)
        ((eql (caar lst) (cadar solucion)) (push (list (car (cddddr (car lst))) (cadr (car lst)) (cadr (cddddr (car lst)))) solucion) (backtrack (cdr lst)))
        (t (backtrack (cdr lst)))))

;regresa T si el estado pertenece al lst de nodos
(defun previo (estado lst)
    (setq nodo (car lst))
    (cond 
        ((null nodo) nil)
        ((equal estado (cadr (cddddr nodo))))
        (t (previo estado (cdr lst)))))

;determina si un obj pertenece a lst
(defun miembro (obj lst)
    (cond
        ((null lst) nil)
        ((equal obj (car lst)) t)
        (t (miembro obj (cdr lst)))))

;encuentra la posicion (y x) de 0 en edo
(defun findIJ (pos edo)
    (cond   
        ((or (null pos) (null edo)))
        ((listp (car edo)) (incf (car pos)) (if (miembro 0 (car edo))
            (findIJ (cdr pos) (car edo))
            (findIJ pos (cdr edo))))
        ((eql 0 (car edo)) (incf (car pos)))
        (t (incf (car pos)) (findIJ pos (cdr edo))))
        pos)

;intercambia el cero de la pos0 con el numero en la posD
(defun swap (var pos0 posD &aux aux)
    (setq aux (nth (- (cadr posD) 1) (nth (- (car posD) 1) var)))
    (incf (nth (- (cadr pos0) 1) (nth (- (car pos0) 1) var)) aux)
    (decf (nth (- (cadr posD) 1) (nth (- (car posD) 1) var)) aux)
    var)

;------- PARAMETROS --------
(terpri)
(princ "Estado inicial : ")
(setq edoInicial (read))
(write edoInicial)

(terpri)
(princ "Estado final : ")
(setq edoFinal (read))
(write edoFinal)
(terpri)
(write edoInicial)

(setq abierto (list (list 0 nil 0 0 -1 edoInicial)) cerrado '() solucion '() movs '((1 0)(-1 0)(0 1)(0 -1)) id 0 limIt 2000 limEx 100)
(setq  posFs (list (findPos 0 '(0 0) edoFinal) (findPos 1 '(0 0) edoFinal) (findPos 2 '(0 0) edoFinal) (findPos 3 '(0 0) edoFinal) (findPos 4 '(0 0) edoFinal) (findPos 5 '(0 0) edoFinal) (findPos 6 '(0 0) edoFinal) (findPos 7 '(0 0) edoFinal) (findPos 8 '(0 0) edoFinal)))

;------- EXECUTE ORDER 66 -------
(astarPuzzle8)
(print solucion) ;para que podamos ver en la terminal la solucion. 

;------- PRUEBAS ------
;(setq edoP '((1 2 3)(4 0 6)(7 5 8)) edo (copy-tree edoP))
;(setq nodo1 '(0 nil 0 0 -1 ((1 2 3)(4 0 5)(6 7 8))) nodo2 '(1 0 2 1 2 ((1 2 3)(0 4 5)(6 7 8))) nodo3 '(2 1 3 2 3 ((1 2 0)(3 4 5)(6 7 8))))
;(setq cerrado (list nodo1 nodo2 nodo3))
;(setq solucion (list (list (car (cddddr mejorNodo)) (cadr mejorNodo))))
;(setq mejorNodo '(3 1 3 2 4 ((1 2 0)(3 4 5)(6 7 8))))
;(setq abierto (list nodo1))
;(setq movs '((1 0)(-1 0)(0 1)(0 -1)))
;edoFinal '((1 2 3)(4 5 6)(7 8 0))

