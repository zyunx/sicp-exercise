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

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))


(define (stream-flatmap proc s)
  (let ((first-stream (proc (stream-car s))))
    (cons-stream (stream-car first-stream)
                 (interleave (stream-cdr first-stream)
                             (stream-flatmap proc (stream-cdr s))))))
