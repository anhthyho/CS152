#lang racket
(define (largest-elem num)
  (cond [(eq? (null? num) #t) 0]
        [else (getmax num (car num))])
  )

(define (getmax num hold)
  (cond[(eq? (null? num) #t) hold]
       [(< hold (car num)) (getmax (cdr num) (car num))]
       [else (getmax (cdr num) hold)])
  )

(define (mult-all num)
  ;(cond [(eq? (null? num) #t) 0]
   ;     [else (mult-rec (cdr num) (car num))])
  (foldl * 1 num)
  )

(define (mult-rec num hold)
  (cond[(eq? (null? num) #t) hold]
       [else (mult-rec (cdr num) (* hold (car num)))])
  )

(define (odd-elements num)
  (cond [(eq? (null? num) #t) empty]
        [else (odd-rec num empty)])
  )

(define (odd-rec num hold)
  (cond[(eq? (null? num) #t) hold]
       [(odd? (car num)) (odd-rec (cdr num) (cons (car num) hold))]
       [else (odd-rec (cdr num) hold)])
  )

(define-syntax-rule (with-prob p e)
  (if (> p (random))
      e
      (void)))

(define-syntax-rule (with-prob-cond p e)
  (let [(x (random))]
    (cond [(> p x) e x]
          [else (void) x])))

(largest-elem (list 0 1 5 2 3))
(mult-all (list 45 66 1 2 3))
;(odd-elements (list 0 1 2 3))

;( with-prob-cond 0.99 ( displayln " 99% chance of printing" ))
;( with-prob-cond 0.5 ( displayln " even money " ))
;( with-prob-cond 0.0001 ( displayln " very rarely prints " ))

;(foldl * 2 (list 1 2 3))
;(foldl *  1 (map (lambda (x) (* x 1))(list 1 2 3)))
;(map (lambda (x) (* x x)) (list 1 2 3))
