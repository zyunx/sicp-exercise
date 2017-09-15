;; display stream at most 'limit' element
(define (display-stream s limit)
  (if (> limit 0)
      (begin (newline)
	     (display (stream-car s))
	     (display-stream (stream-cdr s)
			     (- limit 1)))
      'end))

(define (integers-start-at n)
  (cons-stream n (integers-start-at (+ n 1))))

(define integers (integers-start-at 1))
