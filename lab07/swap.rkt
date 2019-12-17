#lang racket
(define-syntax swap
  (syntax-rules ()
    [(swap x y)
     (let ([tmp x])
       (set! x y)
       (set! y tmp))]))

(define-syntax rotate
  (syntax-rules ()
  [(rotate a b) (swap a b)]
  [(rotate a b c) (begin(swap a b )(swap b c))] 
  ))

(define-syntax rotate-all
  (syntax-rules ()
  [(rotate-all a) (void) ]
  [(rotate-all a b rest ...)
   (begin (swap a b)
          (rotate-all b rest ...))] ;will eventually touch on base case 
  ))

;; example to call on swap/rotate-all/rotate 
(let ([a 7][b 3][c 5])
  (rotate-all a b c)
  (displayln a)
  (displayln b)
  (displayln c))