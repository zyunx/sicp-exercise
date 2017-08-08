;;
(load "~/sicp/sicp-exercise/example/2.4/2.4-op.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4-op.scm"... done
;Value: div-complex

(load "~/sicp/sicp-exercise/common/tag.scm")
;Loading "sicp/sicp-exercise/common/tag.scm"... done
;Value: attach-tag

(load "~/sicp/sicp-exercise/common/operation-table.scm")
;Loading "sicp/sicp-exercise/common/operation-table.scm"... done
;Value: get

(load "~/sicp/sicp-exercise/example/2.4/2.4.3-rect.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4.3-rect.scm"... done
;Value: install-rectangular-package

(load "~/sicp/sicp-exercise/example/2.4/2.4.3-polar.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4.3-polar.scm"... done
;Value: install-polar-package

(load "~/sicp/sicp-exercise/example/2.4/2.4.3-additive.scm")
;Loading "sicp/sicp-exercise/example/2.4/2.4.3-additive.scm"... done
;Value: ang-part

(define make-from-real-imag (get 'make-from-real-imag 'rectangular))
;Value: make-from-real-imag

(define make-from-mag-ang (get 'make-from-mag-ang 'polar))
;Value: make-from-mag-ang

(install-rectangular-package)
;Value: done

(install-polar-package)
;Value: done

(define z1 (make-from-real-imag 1 2))
;Value: z1

(define z2 (make-from-real-imag 3 4))
;Value: z2

(define z3 (make-from-mag-ang 2 (/ 3.1415926 6)))
;Value: z3

(define z4 (make-from-mag-ang 5 1.5707963))
;Value: z4

(ang-part (mul-complex z3 z4))
;Value: 2.094395066666667
;Value: 2.094395066666667
;Value: 10

(add-complex z1 z2)
;Value 15: (rectangular 4 . 6)
;Value 20: (rectangular 4 . 6)

(sub-complex z1 z2)
;Value 16: (rectangular -2 . -2)
;Value 21: (rectangular -2 . -2)

(real-part (mul-complex z1 z2))
;Value: -5.
;Value: -5.
;Value 22: (polar 11.180339887498949 . 2.0344439357957027)

(div-complex z1 z2)
;Value 17: (polar .447213595499958 . .17985349979247822)
;Value 23: (polar .447213595499958 . .17985349979247822)

(mul-complex z2 (make-from-real-imag .44 .0799999999999999999999))
;Value 18: (polar 2.23606797749979 . 1.1071487177940904)
;Value 24: (polar 2.23606797749979 . 1.1071487177940904)


