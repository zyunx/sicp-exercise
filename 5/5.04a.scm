(controller
  (assign continue (label expt-done))
  expt-start:
  (test (op =) (reg n) (const 0))
  (branch (label expt-base-case))
  ; save args
  (save n)
  (assign n (op -) (reg n) (const 1))
  ; call function
  (save continue)
  (assign continue (label after-expt))
  (goto (label expt-start))
  after-expt
  (restore continue)
  ; restore args
  (restore n)
  ; rest processing
  (assign val (op *) (reg b) (reg val))
  ; return function call
  (goto (reg continue)

  expt-base-case
  (assign val (const 1))
  ; return function call
  (goto (reg continue))
  expt-done)
