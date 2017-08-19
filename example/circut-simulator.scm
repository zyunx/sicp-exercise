;; half-adder
(define (half-adder a b s c)
  (let ((d (make-wire))
	(e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))
;Value: half-adder

;; full-adder
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
	(c1 (make-wire))
	(c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))
;Value: full-adder

;; make-wire, and-gate, or-gate, inverter implementation
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
;Value: inverter

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
	   (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
;Value: and-gate

;; logical-not, logical-and
(define (logical-not input)
  (cond ((= input 1) 0)
	((= input 0) 1)
	(else (error "invalid input " input " -- LOGICAL-NOT"))))
;Value: logical-not


(define (logical-and a1 a2)
  (if (and (= a1 1)
	   (= a2 1))
      1
      0))
;Value: logical-and

;; or-gate
(define (or-gate a1 a2 output)
  (let ((b (make-wire))
	(c (make-wire))
	(d (make-wire)))
    (inverter a1 b)
    (inverter a2 c)
    (and-gate b c d)
    (inverter d output)))
;Value: or-gate

(define inverter-delay 2)
;Value: inverter-delay
(define and-gate-delay 4)
;Value: and-gate-delay
 
;; wire implementation
(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
	  (begin (set! signal-value new-value)
		 (call-each action-procedures))
	  'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))

    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
	    ((eq? m 'set-signal!) set-my-signal!)
	    ((eq? m 'add-action!) accept-action-procedure!)
	    (else (error "Unkown operation -- WIRE" m))))
    dispatch))
;Value: make-wire

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
	((car procedures))
	(call-each (cdr procedures)))))
;Value: call-each

(define (get-signal wire)
  (wire 'get-signal))
;Value: get-signal

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
;Value: set-signal!

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))
;Value: add-action!

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
		  action
		  the-agenda))
;Value: after-delay

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
	(first-item)
	(remove-first-agenda-item! the-agenda)
	(propagate))))
;Value: propagate

(define (probe name wire)
  (add-action! wire
	       (lambda ()
		 (newline)
		 (display name)
		 (display " ")
		 (display (current-time the-agenda))
		 (display " New-value = ")
		 (display (get-signal wire)))))
;Value: probe

;; agenda implementation
(define (make-time-segment time queue)
  (cons time queue))
;Value: make-time-segment

(define (segment-time s) (car s))
;Value: segment-time

(define (segment-queue s) (cdr s))
;Value: segment-queue

(define (make-agenda) (list 0))
;Value: make-agenda

(define (current-time agenda) (car agenda))
;Value: current-time

(define (set-current-time! agenda time)
  (set-car! agenda time))
;Value: set-current-time!

(define (segments agenda) (cdr agenda))
;Value: segments

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))
;Value: set-segments!

(define (first-segment agenda) (car (segments agenda)))
;Value: first-segment

(define (rest-segments agenda) (cdr (segments agenda)))
;Value: rest-segments

(define (empty-agenda? agenda)
  (null? (segments agenda)))
;Value: empty-agenda?

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
	(< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
	(insert-queue! (segment-queue (car segments))
		       action)
	(let ((rest (cdr segments)))
	  (if (belongs-before? rest)
	      (set-cdr!
	       segments
	       (cons (make-new-time-segment time action)
		     (cdr segments)))
	      (add-to-segments! rest)))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
	(set-segments! agenda
		       (cons (make-new-time-segment time action)
			     segments))
	(add-to-segments! segments))))
;Value: add-to-agenda!

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
	(set-segments agenda (rest-segments agenda)))))
;Value: remove-first-agenda-item!

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
	(set-current-time! agenda (segment-time first-seg))
	(front-queue (segment-queue first-seg)))))
;Value: first-agenda-item

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


;; test
(define the-agenda (make-agenda))
;Value: the-agenda

(define input-1 (make-wire))
;Value: input-1

(define input-2 (make-wire))
;Value: input-2

(define sum (make-wire))
;Value: sum


(define carry (make-wire))
;Value: carry

(probe 'sum sum)

sum 0 New-value = 0
;Unspecified return value

(probe 'carry carry)

carry 0 New-value = 0
;Unspecified return value

(half-adder input-1 input-2 sum carry)
;Value: ok

(propagate)

sum 24 New-value = 1
;Value: done


(set-signal! input-1 1)
;Value: done






















