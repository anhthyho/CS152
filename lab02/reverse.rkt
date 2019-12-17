#lang racket
(define (reverse lst)
  (cond [(empty? lst) lst]
        [else (append (reverse (cdr lst))
              (cons (car lst) empty))]))

(reverse (list 1 2 3))