(defun clear () (screen:clear-window (screen:make-window)))


nodo=(ID padre f(x) g(x) movimiento (estado))

movs=((1 0) (-1 0) (0 1) (0 -1))
        4      3     2      1

solucion=((mov padre) (mov padre) ...)


(setq abierto (list nodoInicial) cerrado '() edoFinal '((1 2 3)(4 0 5)(6 7 8)))
(setq solucion '())
(setq movs '((1 0)(-1 0)(0 1)(0 -1)))
(setq id 0)
(defun astarPuzzle8 (abierto cerrado)
    (setf mejorNodo (pop abierto))
    (cond 
        ((null mejorNodo) 
            (print 'NO_HAY_SOLUCION))
        ((equal (car (cddddr mejorNodo)) edoFinal) 
            (setq solucion (append solucion (list (list (cadddr mejorNodo) (cadr mejorNodo))))) (backtrack (reverse cerrado)))
        ((previo (car (cddddr mejorNodo) (cdr cerrado))) 
            (setq abierto (cdr abierto)) 
            (astarPuzzle8 abierto cerrado))
        (t (generaHijos mejorNodo) 
            (setq cerrado (append cerrado (list mejorNodo)) abierto (cdr abierto)) 
            (sort abierto #'< :key #'third) 
            (astarPuzzle8 abierto cerrado))))

;dado un nodo se generan sus hijos y se agregan a abierto
(defun generaHijos (nodo movs)
    (cond 
        ((null movs))
        (t 
            (let* ((edoP (cadr (cddddr nodo)))(edoH (generaEdo edoP (car movs)))(nodoH)(g (+ (nth 3 nodo) 1)))
                (cond
                    ((null edoH))
                    (t (setf nodoH (list (+ id 1) (car nodo) (costoF g edoH) g (length movs) edoH)) (incf id) (push nodoH abierto))
                )
            )
            (generaHijos nodo (cdr movs))
        )
    )
)

;calcula el costo de un estado (distancia de hamming o Brooklyn)
(defun costoF (g edo)
    -1)

;genera un estado dado el padre y el mov a realizar, regresa nil si no es valido el mov
(defun generaEdo (edoP mov &aux posA posD)
    ;arma que el nodo sea justo de la forma especifica y le mete todo lo que se necesita
    (setq edo (copy-tree edoP))
    (let* ((d0 (copy-tree '(0 0)))(posA (findij d0 edo))(posD (list (+ (car posA) (car mov)) (+ (cadr posA) (cadr mov)))))
    (cond
        ((and (>= 3 (car posD) 1) (>= 3 (cadr posD) 1))(swap edo posA posD))
        (t nil)))
)

;recorre cerrado para obtener el conjunto de movimientos que llevan del estado inicial al estado final
(defun backtrack (lst)
    (cond
        ((null lst) (print solucion))
        ((eql (caar lst) (cadar (reverse solucion))) (push (list (car (cddddr (car lst))) (cadr (car lst))) solucion) (backtrack (cdr lst)))
        (t (backtrack (cdr lst)))))

;regresa T si el estado pertenece al lst de nodos
(defun previo (estado lst)
    (setq nodo (car lst))
    (cond 
        ((null nodo) nil)
        ((equal estado (cadr (cddddr nodo))))
        (t (previo estado (cdr lst)))))

(defun miembro (obj lst)
    (cond
        ((null lst) nil)
        ((equal obj (car lst)) t)
        (t (miembro obj (cdr lst)))))

(defun findIJ (pos edo)
    (cond   
        ((or (null pos) (null edo)))
        ((listp (car edo)) (incf (car pos)) (if (miembro 0 (car edo))
            (findIJ (cdr pos) (car edo))
            (findIJ pos (cdr edo))))
        ((eql 0 (car edo)) (incf (car pos)))
        (t (incf (car pos)) (findIJ pos (cdr edo))))
        pos)

(defun swap (var pos0 posD &aux aux)
    (setq aux (nth (- (cadr posD) 1) (nth (- (car posD) 1) var)))
    (incf (nth (- (cadr pos0) 1) (nth (- (car pos0) 1) var)) aux)
    (decf (nth (- (cadr posD) 1) (nth (- (car posD) 1) var)) aux)
    var)

;algunas pruebas
(setq edoP '((1 2 3)(4 0 6)(7 5 8)) edo (copy-tree edoP))
(setq nodo1 '(0 nil 0 0 nil ((1 2 3)(4 0 5)(6 7 8))) nodo2 '(1 0 2 1 2 ((1 2 3)(0 4 5)(6 7 8))) nodo3 '(2 1 3 2 3 ((1 2 0)(3 4 5)(6 7 8))))
(setq cerrado (list nodo1 nodo2 nodo3))
(setq solucion (list (list (car (cddddr mejorNodo)) (cadr mejorNodo))))
(setq mejorNodo '(3 1 3 2 4 ((1 2 0)(3 4 5)(6 7 8))))
(setq abierto (list nodo1))
(setq movs '((1 0)(-1 0)(0 1)(0 -1)))
