(put 'eval 'let (lambda (exp env) (eval (let->combination exp) env)))

(define (let->combination exp)
  (cons (make-lambda (let-vars exp)
                     (let-body exp))
        (let-vals exp)))

(define (let-body exp)
  (cddr exp))
;Value: let-body


(define (let-vars exp)
  (map car (cadr exp)))
;Value: let-vars



(define (let-vals exp)
  (map cadr (cadr exp)))
;Value: let-vals

(let-vals '(let ((a 1) (b 2)) (+ a 2) (x 1 1)))
