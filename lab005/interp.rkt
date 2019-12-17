#lang racket

;; Expressions in the language
(struct b-val (val))
(struct b-if (c thn els))
(struct b-sum (exp))
(struct b-sub (exp))

;; Main evaluate method
(define (evaluate prog)
  (match prog
    [(struct b-val (v)) v]
    [(struct b-if (c thn els))
    (if (evaluate c)
         (evaluate thn)
         (evaluate els))]
    ;creates struct out of value v for sum proc
    [(struct b-sum(exp))
     (let ([num (evaluate exp)])
       ;if num is a number, add 1, else 0
      (if (number? num)(+ num 1) 0))]
    ;creates struct out of value v for sub proc
    [(struct b-sub(exp))
     (let ([num (evaluate exp)])
       ;if num is a number, sub 1, else 0 
      (if (number? num)(- num 1) 0))]
    [_ (error "Unrecognized expression")]))

(evaluate (b-val #t))
(evaluate (b-val #f))
(evaluate (b-if (b-val #t)
                (b-if (b-val #f) (b-val #t) (b-val #f))
                (b-val #f)))


;calls to evaluate validty of some value num and leads to +1
(define (succ num)
   (evaluate (b-sum (b-val num)))
  )

;calls to evaluate validty of some value num and leads to -1
(define (pred num)
  (evaluate (b-sub (b-val num))))



;; Consider the following sample programs for extending the interpreter
; succ 1  =>  returns 2
; succ (succ 7) => returns 9
; pred 5 => returns 4
; succ (if true then 42 else 0) => 43