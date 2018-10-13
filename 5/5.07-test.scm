(define test-machine
  (make-machine
    '(a b)
    (list (list '+ +))
    '(
      test-start
      (assign b (op +) (reg a) (const 1))
      test-end)))

(set-register-contents! test-machine 'a 100)

(start test-machine)

(get-register-contents test-machine 'b)
