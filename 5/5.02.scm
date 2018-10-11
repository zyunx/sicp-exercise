(data-paths
  (registers
    ((name n))
    ((name p) 
     (buttons ((name p<-tp) (source (register tp)))))
    ((name c)
     (buttons ((name c<-tc) (source (register tc)))))
    ((name tp)
     (buttons ((name tp<-*) (source (operation *)))))
    ((name tc)
     (buttons ((name tc<-+1) (source (operation +1))))))
  (operations
    ((name *)
     (inputs (register p) (register c)))
    ((name +1)
     (inputs (register c)))
    ((name >)
     (inputs (register c) (register n)))))


(controller
  test-c>n
  (test >)
  (branch (label factorial-done))
  (tp<-*)
  (p<-tp)
  (tc<-+1)
  (c<-tc)
  (goto (label test-c>n))
  factorial-done)

;;

(controller
  test-c>n
  (test (op >) (reg c) (reg n))
  (branch (label factorial-done))
  (assign tp (op *) (reg p) (reg c))
  (assign p (reg tp))
  (assign tc (op +1) (reg c))
  (assign c (reg tc))
  (goto (label test-c>n))
  factorial-done)
