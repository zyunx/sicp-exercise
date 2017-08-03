;;
(load "~/sicp/sicp-exercise/example/2.4/2.4-op.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4-op.scm"... done
;Value: div-complex

(load "~/sicp/sicp-exercise/common/tag.scm")
;Loading "sicp/sicp-exercise/common/tag.scm"... done
;Value: attach-tag

(load "~/sicp/sicp-exercise/example/2.4/2.4-real-imag.scm")

(load "~/sicp/sicp-exercise/example/2.4/2.4-polar.scm")

(load "~/sicp/sicp-exercise/example/2.4/2.4-coexist.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4-coexist.scm"... done
;Value: make-from-mag-ang

(define z1 (make-from-real-imag 1 2))
;Value: z1

(define z2 (make-from-real-imag 3 4))
;Value: z2

(define z3 (make-from-mag-ang 2 (/ 3.1415926 6)))
;Value: z3

(define z4 (make-from-mag-ang 5 1.5707963))


(ang-part (mul-complex z3 z4))
;Value: 2.094395066666667
;Value: 10

(add-complex z1 z2)
;Value 20: (rectangular 4 . 6)

(sub-complex z1 z2)
;Value 21: (rectangular -2 . -2)

(real-part (mul-complex z1 z2))
;Value: -5.
;Value 22: (polar 11.180339887498949 . 2.0344439357957027)

(div-complex z1 z2)
;Value 23: (polar .447213595499958 . .17985349979247822)

(mul-complex z2 (make-from-real-imag .44 .0799999999999999999999))
;Value 24: (polar 2.23606797749979 . 1.1071487177940904)


