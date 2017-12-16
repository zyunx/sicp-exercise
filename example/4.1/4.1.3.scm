;; 4.1.3 Evaluator Data Structures
(define (true? x)
  (not (eq? x false)))
;Value: true?

(define (false? x)
  (eq? x false))
;Value: false?

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
;Value: make-procedure

(define (compound-procedure? p)
  (tagged-list? p 'procedure))
;Value: compound-procedure?

(define (procedure-parameters p) (cadr p))
;Value: procedure-parameters

(define (procedure-body p) (caddr p))
;Value: procedure-body

(define (procedure-environment p) (cadddr p))
;Value: procedure-enviroment

;; Operations on Enviroments
(define (enclosing-environment env) (cdr env))
;Value: enclosing-environment

(define (first-frame env) (car env))
;Value: first-frame

(define the-empty-environment '())
;Value: the-empty-environment

(define (make-frame variables values)
  (cons variables values))
;Value: make-frame

(define (frame-variables frame) (car frame))
;Value: frame-variables

(define (frame-values frame) (cdr frame))
;Value: frame-values

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))
;Value: add-binding-to-frame!

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
	  (error "Too many arguments supplied" vars vals)
	  (error "Too few arguments supplied" vars vals))))
;Value: extend-environment

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
	     (env-loop (enclosing-environment env)))
	    ((eq? var (car vars))
	     (car vals))
	    (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
	(error "Unbound variable" var)
	(let ((frame (first-frame env)))
	  (scan (frame-variables frame)
		(frame-values frame)))))
  (env-loop env))
;Value: lookup-variable-value

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
	     (env-loop (enclosing-environment env)))
	    ((eq? var (car vars))
	     (set-car! vals val))
	    (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
	(error "Unbound variable -- SET!" var)
	(let ((frame (first-frame env)))
	  (scan (frame-variables frame)
		(frame-values frame)))))

  (env-loop env))
;Value: set-variable-value!

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
	     (add-binding-to-frame! var val frame))
	    ((eq? var (car vars))
	     (set-car! vals val))
	    (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
	  (frame-values frame))))
;Value: define-variable!

