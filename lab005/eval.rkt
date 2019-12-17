#lang racket
(struct b-val (val))
(struct b-if (c then else))

(define (evaluate prog)
  (match prog
    [(struct b-val (v)) v]
    [(struct b-if (e1 e2 e3))
     (if (evaluate e1)
         (evaluate e2)
         (evaluate e3))])
  )