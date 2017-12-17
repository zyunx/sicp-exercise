
(define (arrow-action? actions) (eq? '=> (car actions)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
	        (rest (cdr clauses)))
	    (if (cond-else-clause? first)
            (if (null? rest)
	            (sequence->exp (cond-actions first))
	            (error "ELSE clause isn't last -- COND->IF" clauses))
	        (make-if (cond-predicate first)
                     (if (arrow-action? (cond-actions first))
                         (list (cadr (cond-actions first))
                               (cond-predicate first))
                         (sequence->exp (cond-actions first)))
                     (expand-clauses rest))))))
;Value: expand-clauses

