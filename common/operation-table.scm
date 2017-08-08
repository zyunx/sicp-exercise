(define (make-operation-table)
  (let ((local-table (list '*table*)))
    (define (equal? a b)
      (if (and (pair? a)
	       (pair? b))
	  (and (equal? (car a) (car b))
	       (equal? (cdr a) (cdr b)))
	  (eq? a b)))

    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
	(if subtable
	    (let ((record (assoc key-2 (cdr subtable))))
	      (if record
		  (cdr record)
		  false))
	    false)))

    (define (assoc key records)
      (cond ((null? records) false)
	    ((equal? key (caar records)) (car records))
	    (else (assoc key (cdr records)))))

    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
	(if subtable
	    (let ((record (assoc key-2 (cdr subtable))))
	      (if record
		  (set-cdr! record value)
		  (set-cdr! subtable
			    (cons (cons key-2 value)
				  (cdr subtable)))))
	    (set-cdr! local-table
		      (cons (list key-1
				  (cons key-2 value))
			    (cdr local-table)))))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	    (else (error "Unknown operation -- TABLE"))))

    dispatch))
;Value: make-operation-table

(define operation-table (make-operation-table))
;Value: operation-table

(define put (operation-table 'insert-proc!))
;Value: put

(define get (operation-table 'lookup-proc))
;Value: get





