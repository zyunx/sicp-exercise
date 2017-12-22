(put 'eval 'let (lambda (exp env) (eval (let->combination exp) env)))

(define (let->combination exp)
  (cons (make-lambda (let-vars exp)
                     (let-body exp))
        (let-vals exp)))

(define (let-bindings exp) (cadr exp))
   
(define (let-body exp)
  (cddr exp))
;Value: let-body


(define (let-vars exp)
  (map car (let-bindings exp)))
;Value: let-vars

(define (let-vals exp)
  (map cadr (let-bindings exp)))
;Value: let-vals

(define (make-let bindings body)
    (list 'let bindings body))
