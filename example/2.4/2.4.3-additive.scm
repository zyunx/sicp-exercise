(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (error
	   "No method for these types -- APPLY-GENERIC"
	   (list op type-tags))))))
;Value: apply-generic

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (mag-part z) (apply-generic 'mag-part z))
(define (ang-part z) (apply-generic 'ang-part z))


