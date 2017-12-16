; from left to righ
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let (
            (rest (list-of-values (rest-operands exps) env))
            (first (eval (first-operand exps) env))
           )
        (cons first rest))))

; from right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let (
            (first (eval (first-operand exps) env))
            (rest (list-of-values (rest-operands exps) env))
           )
        (cons first rest))))
