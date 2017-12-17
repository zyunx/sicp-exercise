(define (self-evaluating? exp)
  (cond ((number? exp) true)
	((string? exp) true)
	(else false)))
;Value: self-evaluating?

(define (variable? exp) (symbol? exp))
;Value: variable?

(define (quoted? exp)
  (tagged-list? exp 'quote))
;Value: quoted?

(define (text-of-quotation exp) (cadr exp))
;Value: text-of-quotation

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
;Value: tagged-list?

(define (assignment? exp)
  (tagged-list? exp 'set!))
;Value: assignment?

(define (assignment-variable exp) (cadr exp))
;Value: assignment-variable

(define (assignment-value exp) (caddr exp))
;Value: assignment-value

(define (definition? exp)
  (tagged-list? exp 'define))
;Value: definition?

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
;Value: definition-variable

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
		   (cddr exp))))
;Value: definition-value

(define (lambda? exp) (tagged-list? exp 'lambda))
;Value: lambda?

(define (lambda-parameters exp) (cadr exp))
;Value: lambda-parameters

(define (lambda-body exp) (cddr exp))
;Value: lambda-body

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
;Value: make-lambda

(define (if? exp) (tagged-list? exp 'if))
;Value: if?

(define (if-predicate exp) (cadr exp))
;Value: if-predicate

(define (if-consequent exp) (caddr exp))
;Value: if-consequent

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
;Value: if-alternative

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
;Value: make-if

(define (begin? exp) (tagged-list? exp 'begin))
;Value: begin?

(define (begin-actions exp) (cdr exp))
;Value: begin-actions

(define (last-exp? seq) (null? (cdr seq)))
;Value: last-exp?

(define (first-exp seq) (car seq))
;Value: first-exp

(define (rest-exps seq) (cdr seq))

;; sequence-if
(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (first-exp seq))
	(else (make-begin seq))))
;Value: sequence->exp

(define (make-begin seq) (cons 'begin seq))
;Value: make-begin

(define (application? exp) (pair? exp))
;Value: application?

(define (operator exp) (car exp))
;Value: operator

(define (operands exp) (cdr exp))
;Value: operands

(define (no-operands? ops) (null? ops))
;Value: no-operands?

(define (first-operand ops) (car ops))
;Value: first-operand

(define (rest-operands ops) (cdr ops))
;Value: rest-operands

(define (cond? exp) (tagged-list? exp 'cond))
;Value: cond?

(define (cond-clauses exp) (cdr exp))
;Value: cond-clauses

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
;Value: cond-else-clause?

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))
;Value: cond-actions

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
;Value: cond->if

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

