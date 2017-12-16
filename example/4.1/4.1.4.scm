;; 4.1.4 Running the Evaluator as a Program
(define (setup-environment)
  (let ((initial-env
	 (extend-environment (primitive-procedure-names)
			     (primitive-procedure-objects)
			     the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))
;Value: setup-environment

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
;Value: primitive-procedure?

(define (primitive-implementation proc) (cadr proc))
;Value: primitive-implementation

(define primitive-procedures
  (list 
	(list '+ +)
	(list '- -)
	(list '* *)
	(list '/ /)
	(list 'car car)
	(list 'cdr cdr)
	(list 'cons cons)
	(list 'null? null?)
	))


;Value: primitive-procedures

(define (primitive-procedure-names)
  (map car primitive-procedures))
;Value: primitive-procedure-names

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))
;Value: primitive-procedure-objects

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))
;Value: apply-primitive-procedure

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
;Value: driver-loop

(define (prompt-for-input string)
  (newline) (display string) (newline))
;Value: prompt-for-input

(define (announce-output string)
  (newline) (display string) (newline))
;Value: announce-output

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))
;Value: user-print


