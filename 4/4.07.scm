(put 'eval 'let* (lambda (exp env) (eval (let*->let exp) env)))

(define (let*->let exp)
  (if (null? (let*-bindings exp))
      (make-let (let*-bindings exp) (let*-body exp))
      (make-let (list (let*-first-bindings exp))
		(let*->let (make-let* (let*-rest-bindings exp)
				      (let*-body exp))))))

(define (make-let* bindings body)
  (list 'let* bindings body))

(define (let*-bindings exp) (cadr exp))

(define (let*-body exp) (caddr exp))

(define (let*-first-bindings exp) (car (let*-bindings exp)))

(define (let*-rest-bindings exp) (cdr (let*-bindings exp)))
