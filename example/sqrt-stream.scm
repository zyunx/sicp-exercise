(define (sqrt-improve guess x)
  (average guess (/ x guess)))
;Value: sqrt-improve

(define (average a b)
  (/ (+ a b) 2))
;Value: average

(define (sqrt-streams x)
  (define guesses
    (cons-stream 1.0
		 (stream-map (lambda (guess)
			       (sqrt-improve guess x))
			     guesses)))
  guesses)
;Value: sqrt-streams

(define (display-stream s limit)
  (if (> limit 0)
      (begin (newline)
	     (display (stream-car s))
	     (display-stream (stream-cdr s)
			     (- limit 1)))
      'end))
;Value: display-stream

(display-stream (sqrt-streams 2) 10)




