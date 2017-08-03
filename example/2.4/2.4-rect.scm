;; complex real-imag representation
(define (make-from-real-imag x y)
  (cons x y))
;Value: make-from-real-imag

(define (make-from-mag-ang r a)
  (cons (* r (cos a))
	(* r (sin a))))
;Value: make-from-mag-ang

(define (real-part z) (car z))
;Value: real-part

(define (imag-part z) (cdr z))
;Value: imag-part

(define (mag-part z)
  (sqrt (+ (square (car z))
	   (square (cdr z)))))
;Value: mag-part

(define (ang-part z)
  (atan (cdr z) (car z)))
;Value: ang-part

