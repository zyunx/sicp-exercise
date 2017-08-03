;; assume that the constructors and selectors is defined
;; make-from-real-imag
;; make-from-mag-ang
;; real-part
;; imag-part
;; mag-part
;; ang-part

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1)
			  (real-part z2))
		       (+ (imag-part z1)
			  (imag-part z2))))
;Value: add-complex

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1)
			  (real-part z2))
		       (- (imag-part z1)
			  (imag-part z2))))
;Value: sub-complex

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (mag-part z1)
			(mag-part z2))
		     (+ (ang-part z1)
			(ang-part z2))))
;Value: mul-complex

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (mag-part z1)
			(mag-part z2))
		     (- (ang-part z1)
			(ang-part z2))))
;Value: div-complex



