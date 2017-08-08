;; install complex rectangular package
(define (install-rectangular-package)

  (define (make-from-real-imag x y)
    (cons x y))

  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
	  (* r (sin a))))

  (define (real-part z) (car z))

  (define (imag-part z) (cdr z))

  (define (mag-part z)
    (sqrt (+ (square (car z))
	     (square (cdr z)))))

  (define (ang-part z)
    (atan (cdr z) (car z)))

  ;; interface to the rest of the system
  (define (tag z) (attach-tag 'rectangular z))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'mag-part '(rectangular) mag-part)
  (put 'ang-part '(rectangular) ang-part)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (x y) (tag (make-from-mag-ang x y))))
  'done)
;Value: install-rectangular-package

