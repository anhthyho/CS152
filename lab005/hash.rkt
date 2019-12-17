#lang racket
(define ht(hash "a" 1 "b" 2))
(hash-ref ht "a")
;(hash-ref ht "c") error
(hash-ref ht "c" 0)
(define htz(hash-set ht "c" 42))
(hash-ref htz "a" 0)