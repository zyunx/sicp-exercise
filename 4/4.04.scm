;; exercise 4.4
(put 'eval 'and (lambda (exp env) (eval-and exp env)))
(put 'eval 'or (lambda (exp env) (eval-or exp env)))

(define (eval-and exp env) (eval-and-predicates (and-predicates exp) env))
(define (eval-or exp env) (eval-or-predicates (or-predicates exp) env))

(define (and-predicates exp) (cdr exp))

(define (eval-and-predicates predicates env)
  (if (null? predicates)
      true
      (let ((first (and-first-predicate predicates))
            (rest (and-rest-predicates predicates)))
        (if (not (eval first env))
            false
            (eval-and-predicates rest env)))))

(define (and-first-predicate predicates)
    (car predicates))
(define (and-rest-predicates predicates)
    (cdr predicates))

(define (or-predicates exp) (cdr exp))

(define (eval-or-predicates predicates env)
  (if (null? predicates)
      false
      (let ((first (or-first-predicate predicates))
            (rest (or-rest-predicates predicates)))
        (if (eval first env)
            true
            (eval-or-predicates rest env)))))

(define (or-first-predicate predicates) (car predicates))
(define (or-rest-predicates predicates) (cdr predicates))
