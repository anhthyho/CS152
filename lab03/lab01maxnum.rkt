#lang racket
(provide max-num)
;; gets the max num out of a list, returns the same number if only one number in list
;; returns error if empty

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


  