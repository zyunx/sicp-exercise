(controller
  (assign p (const 1))
  (assign c (reg n))
  expt-loop
  (test (op =) (reg c) (const 0))
  (branch (label expt-done))
  (assign c (op -) (reg c) (const 1))
  (assign p (op *) (reg b) (reg p))
  (goto (label expt-loop))
  expt-done)
