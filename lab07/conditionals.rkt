#lang racket

(define (my-if c thn els)
  (cond
    [(and (list? c) (empty? c)) els]
    [(and (number? c) (= 0 c)) els]
    [(and (boolean? c) (not c)) els]
    [else thn]))

(my-if 0 1 0)
