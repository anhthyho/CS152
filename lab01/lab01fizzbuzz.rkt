#lang racket
(provide fizzbuzz)

;; The function counts from 1 to the specified number, printing a string with the result.
;; The rules are:
;;    If a number is divisible by 3 and by 5, instead say "fizzbuzz"
;;    Else if a number is divisible by 3, instead say "fizz"
;;    Else if a number is divisible by 5, instead say "buzz"
;;    Otherwise say the number
;;

(define (fizzbuzz n)
  (maintain 1 n ""))

;; fizzbuzz n - function calls to create string for fizzbuzz
;; a keeps count of iterations
;; n maintains the original fizzbuzz target number
;; b is the string to be returns (appended)
(define (maintain a n b)
 (cond       
        [(= (- a 1) n) (string-append b "")]
        [(and (zero? (modulo a 3))(zero? (modulo a 5))) (maintain (+ a 1) n (string-append b "fizzbuzz ")) ]
        [(zero? (modulo a 5)) (maintain (+ a 1) n (string-append b "buzz "))]
        [(zero? (modulo a 3))(maintain (+ a 1) n (string-append b "fizz "))]
        [else (maintain (+ a 1) n (string-append b (number->string a) " ")) ]
        ))
 


