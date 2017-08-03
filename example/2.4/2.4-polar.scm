;; polar representation
(define (make-from-mag-ang r a)
  (cons r a))
;Value: make-from-mag-ang

(define (make-from-real-imag x y)
  (cons (sqrt (+ (square x)
		 (square y)))
	(atan y x)))
;Value: make-from-real-imag

(define (real-part z1)
  (* (mag-part z1)
     (cos (ang-part z1))))
;Value: real-part

(define (imag-part z)
  (* (mag-part z)
     (sin (ang-part z))))
;Value: imag-part

(define (mag-part z) (car z))
;Value: mag-part

(define (ang-part z) (cdr z))
;Value: ang-part



;Loading "sicp/sicp-exercise/example/2.4/2.4-polar.scm"... done
;Value: ang-part

;Loading "sicp/sicp-exercise/example/2.4/2.4-polar.scm"... done
;Value: ang-part

;Value: z1

;Value: z2

;Value: z3

;Value: z4

;Unbound variable: mul-complex
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of mul-complex.
; (RESTART 2) => Define mul-complex to a given value.
; (RESTART 1) => Return to read-eval-print level 1.
;Start debugger? (y or n): 