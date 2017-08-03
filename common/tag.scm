;; type tag
(define (type-tag datum) (car datum))
;Value: type-tag

(define (contents datum) (cdr datum))
;Value: contents

(define (attach-tag type-tag contents)
  (cons type-tag contents))
;Value: attach-tag


