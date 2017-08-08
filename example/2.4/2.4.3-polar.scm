;; install polar representation
(define (install-polar-package)
  (define (make-from-mag-ang r a)
    (cons r a))

  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x)
		   (square y)))
	  (atan y x)))

  (define (real-part z1)
    (* (mag-part z1)
       (cos (ang-part z1))))

  (define (imag-part z)
    (* (mag-part z)
       (sin (ang-part z))))

  (define (mag-part z) (car z))

  (define (ang-part z) (cdr z))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'mag-part '(polar) mag-part)
  (put 'ang-part '(polar) ang-part)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
;Value: install-polar-package


