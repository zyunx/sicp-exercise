(define test-machine
  (make-machine
    '(b n val continue)
    (list (list '* *) (list '- -) (list '= =))
    '(
      (assign continue (label expt-done))
      expt-start
      (test (op =) (reg n) (const 0))
      (branch (label expt-base-case))
      (save n)
      (assign n (op -) (reg n) (const 1))
      (save continue)
      (assign continue (label after-expt))
      (goto (label expt-start))
      after-expt
      (restore continue)
      (restore n)
      (assign val (op *) (reg b) (reg val))
      (goto (reg continue))
      expt-base-case
      (assign val (const 1))
      (goto (reg continue))
      expt-done
      )))

(set-register-contents! test-machine 'b 2)
(set-register-contents! test-machine 'n 10)
(start test-machine)
(get-register-contents test-machine 'val)
