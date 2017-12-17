;; exercise 4.4
(put 'eval 'and (lambda (exp env) (eval (and->if exp) env)))
(put 'eval 'or (lambda (exp env) (eval (or->if exp) env)))

(define (and->if exp)
    (expand-and-predicates (and-predicates exp)))

(define (and-predicates exp) (cdr exp))

(define (expand-and-predicates predicates)
    (if (null? predicates)
        'true
        (make-if (and-first-predicate predicates)
                 (expand-and-predicates (and-rest-predicates predicates))
                 'false)))

(define (and-first-predicate predicates)
    (car predicates))
(define (and-rest-predicates predicates)
    (cdr predicates))

(define (or->if exp)
    (expand-or-predicates (or-predicates exp)))

(define (or-predicates exp) (cdr exp))

(define (expand-or-predicates predicates)
    (if (null? predicates)
        'false
        (make-if (or-first-predicate predicates)
                 'true
                 (expand-or-predicates (or-rest-predicates predicates)))))

(define (or-first-predicate predicates) (car predicates))
(define (or-rest-predicates predicates) (cdr predicates))
