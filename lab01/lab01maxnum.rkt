#lang racket
(provide max-num)
(define (max-num lst)
  (cond [(null? lst) error "error: empty"]
        [(null? (cdr lst)) (car lst)]
        [(null? (cdr (rest lst)))
         (if (> (car lst) (car (rest lst))) (car lst)
             (car (rest lst)))]
        [(> (car lst) (car (rest lst)))(max-num (rest lst))]
        [(< (car lst) (car (rest lst))) (max-num (rest lst))]
        
        )
  )


(max-num (list 2 11 15 3))
  