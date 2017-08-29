(load "~/sicp/sicp-exercise/common/stream.scm")
;Loading "sicp/sicp-exercise/common/stream.scm"... done
;Value: integers

(define (div-streams s1 s2)
  (stream-map (lambda (e1 e2) (/ e1 e2))
	      s1 s2))
;Value: div-streams

(define (integrate-series power-serial)
  (div-streams power-serial integers))
;Value: integrate-series

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
;Value: exp-series

(stream-ref exp-series 4)
;Value: 1/24
;Value: 1/6
;Value: 1/2
;Value: 1

(define (scale-stream c s)
  (stream-map (lambda (e) (* c e))
       	      s))
;Value: scale-stream

(define cos-series
  (cons-stream 1 (integrate-series (scale-stream -1 sin-series))))
;Value: cos-series

(define sin-series
  (cons-stream 0 (integrate-series cos-series)))
;Value: sin-series

(stream-ref sin-series 5)
;Value: 1/120
;Value: 0
;Value: -1/6
;Value: 0
;Value: 1
;Value: 0

(stream-ref cos-series 4)
;Value: 1/24
;Value: 0
;Value: -1/2
;Value: 0
;Value: 1



