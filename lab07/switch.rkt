#lang racket
(define-syntax switch
  (syntax-rules ()
    {(switch x) (empty)}
    {(switch x [default exp]) exp}
    {(switch x [val exp] remainder ...)
     (if (eqv? x val)
         exp
         (switch x remainder ...))}))

(define x 99)
(switch x
    [3 (displayln "x is 3")]
    [4 (displayln "x is 4")]
    [5 (displayln "x is 5")]
    [default (displayln "none of the above")])

(define y 3)
(switch y
    [3 (displayln "x is 3")]
    [4 (displayln "x is 4")]
    [5 (displayln "x is 5")]
    [default (displayln "none of the above")])

(define z 5)
(switch z
    [3 (displayln "x is 3")]
    [4 (displayln "x is 4")]
    [5 (displayln "x is 5")]
    [default (displayln "none of the above")])