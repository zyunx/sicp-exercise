;;
(load "~/sicp/sicp-exercise/example/2.4/2.4-op.scm")


(load "~/sicp/sicp-exercise/example/2.4/2.4-real-imag.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4-real-imag.scm"... done
;Value: ang-part

(load "~/sicp/sicp-exercise/example/2.4/2.4-polar.scm")

(define z1 (make-from-real-imag 1 2))

(define z2 (make-from-real-imag 3 4))


(define z3 (make-from-mag-ang 2 (/ 3.1415926 6)))


(define z4 (make-from-mag-ang 5 1.5707963))


(ang-part (mul-complex z3 z4))

(add-complex z1 z2)
;Value 13: (4 . 6)

(sub-complex z1 z2)
;Value 14: (-2 . -2)

(mul-complex z1 z2)
;Value 15: (-5. . 10.)

(div-complex z1 z2)
;Value 16: (.44 . .07999999999999999)

(mul-complex z2 (make-from-real-imag .44 .0799999999999999999999))




