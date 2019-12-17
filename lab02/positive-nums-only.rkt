#lang racket

(provide positive-nums-only)

(define (saveList lst lst2)
  (cond [(null? lst) lst2]
        [(> (car lst) 0)(saveList (cdr lst) (append lst2 (list (car lst))))]
        [else (saveList (cdr lst) lst2)])
                            
  )

(define (positive-nums-only lst)
   (saveList lst (list ))
  )
