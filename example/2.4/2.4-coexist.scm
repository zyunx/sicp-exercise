(define (rectangular? z)
  (eq? 'rectangular (type-tag z)))
;Value: rectangular?

(define (polar? z)
  (eq? 'polar (type-tag z)))
;Value: polar?

;; complex real-imag representation
(define (make-from-real-imag-rectangular x y)
  (cons x y))

(define (make-from-mag-ang-rectangular r a)
  (cons (* r (cos a))
	(* r (sin a))))

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))


(define (mag-part-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
	   (square (imag-part-rectangular z)))))

(define (ang-part-rectangular z)
  (atan (imag-part-rectangular z) (real-part-rectangular z)))

;; polar representation
(define (make-from-mag-ang-polar r a)
  (cons r a))

(define (make-from-real-imag-polar x y)
  (cons (sqrt (+ (square x)
		 (square y)))
	(atan y x)))

(define (real-part-polar z1)
  (* (mag-part-polar z1)
     (cos (ang-part-polar z1))))

(define (imag-part-polar z)
  (* (mag-part-polar z)
     (sin (ang-part-polar z))))

(define (mag-part-polar z) (car z))

(define (ang-part-polar z) (cdr z))


;; constructors and generic selectors
(define (real-part z)
  (cond ((rectangular? z)
	 (real-part-rectangular (contents z)))
	((polar? z)
	 (real-part-polar (contents z)))
	(else (error "Unknown type -- REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z)
	 (imag-part-rectangular (contents z)))
	((polar? z)
	 (imag-part-polar (contents z)))
	(else (error "Unkown type -- IMAG-PART" z))))

(define (mag-part z)
  (cond ((rectangular? z)
	 (mag-part-rectangular (contents z)))
	((polar? z)
	 (mag-part-polar (contents z)))
	(else (error "Unkown type -- MAG-PART" z))))

(define (ang-part z)
  (cond ((rectangular? z)
	 (ang-part-rectangular (contents z)))
	((polar? z)
	 (ang-part-polar (contents z)))
	(else (error "Unkown type -- ANG-PART" z))))

(define (make-from-real-imag x y)
  (attach-tag 'rectangular
              (make-from-real-imag-rectangular x y)))

(define (make-from-mag-ang r a)
  (attach-tag 'polar
              (make-from-mag-ang-polar r a)))
