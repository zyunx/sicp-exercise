(define test-machine
  (make-machine
    '(b n c p)
    (list (list '* *) (list '- -) (list '= =))
    '(
      (assign p (const 1))
      (assign c (reg n))
      expt-loop
      (test (op =) (reg c) (const 0))
      (branch (label expt-done))
      (assign c (op -) (reg c) (const 1))
      (assign p (op *) (reg b) (reg p))
      (goto (label expt-loop))
      expt-done)
     ))

(set-register-contents! test-machine 'b 2)
(set-register-contents! test-machine 'n 10)
(start test-machine)
(get-register-contents test-machine 'p)
