;; queue implementation
(define (make-queue) (cons '() '()))
;Value: make-queue
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))
;Value: front-queue

(define (empty-queue? queue) (null? (front-ptr queue)))
;Value: empty-queue?

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
	   (set-front-ptr! queue new-pair)
	   (set-rear-ptr! queue new-pair)
	   queue)
	  (else
	   (set-cdr! (rear-ptr queue) new-pair)
	   (set-rear-ptr! queue new-pair)
	   queue))))
;Value: insert-queue!

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
	 (error "DELETE! called with an empty queue" queue))
	(else
	 (set-front-ptr! queue (cdr (front-ptr queue)))
	 queue)))
;Value: delete-queue!

(define (front-ptr queue) (car queue))
;Value: front-ptr

(define (rear-ptr queue) (cdr queue))
;Value: rear-ptr

(define (set-front-ptr! queue item) (set-car! queue item))
;Value: set-front-ptr!

(define (set-rear-ptr! queue item) (set-cdr! queue item))
;Value: set-rear-ptr!

