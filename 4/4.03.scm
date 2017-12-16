
(load "./common/operation-table.scm")

(put 'eval 'set! (lambda (exp env) (eval-assignment exp env)))
(put 'eval 'define (lambda (exp env) (eval-definition exp env)))
(put 'eval 'if (lambda (exp env) (eval-if exp env)))
(put 'eval 'lambda (lambda (exp env) (make-procedure
                                        (lambda-parameters exp)
                                        (lambda-body exp)
                                        env)))
(put 'eval 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env)))
(put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env)))

(define (special-form exp) (car exp))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
	((quoted? exp) (text-of-quotation exp))
    (else
       (let ((special-exp-eval (get 'eval (special-form exp))))
         (cond (special-exp-eval (special-exp-eval exp env))
               ((application? exp)
                (apply (eval (operator exp) env)
		               (list-of-values (operands exp) env)))
	           (else
	            (error "Unkown expression type -- EVAL" exp)))))))
;Value: eval


