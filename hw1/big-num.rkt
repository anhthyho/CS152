#lang racket

;; The big-num data structure is essentially a list of 3 digit numbers.

;; Exporting methods
(provide big-add big-subtract big-multiply big-power-of pretty-print number->bignum string->bignum)

(define MAX_BLOCK 1000)

;; Addition of two big-nums
(define (big-add x y)
  (big-add1 x y 0)
  )

(define (big-add1 x y co)
   (cond
    ;; If both lists are empty, the return value is either 0 or the caryover value.
    [(and (= 0 (length x)) (= 0 (length y)))
      (if (= co 0) '() (list co))]
    [(= 0 (length x))  (big-add1 (list co) y 0)]
    [(= 0 (length y))  (big-add1 x (list co) 0)]
    [else
     (append (list(removecarry (+ (car x) (car y) co))) (big-add1  (cdr x) (cdr y) (carry(+ (car x) (car y) co))))
     
     ]
    )
  )



(define (carry x)
 (cond [(> (string-length(number->string x)) 3) (string->number(substring(number->string x) 0 (- (string-length (number->string x)) 3)))]
 [else 0])
  )

(define (removecarry x)
  (cond [(> (string-length(number->string x)) 3) (string->number(substring(number->string x) (- (string-length (number->string x)) 3)))]
        [else x]
        )
  )

;; Subtraction of two big-nums
(define (big-subtract x y)
  (let ([lst (big-subtract1 x y 0)])
    (reverse (strip-leading-zeroes (reverse lst)))
  ))

(define (strip-leading-zeroes x)
  (cond
    [(= 0 (length x)) '(0)]
    [(= 0 (car x)) (strip-leading-zeroes (cdr x))]
    [else x]
    ))

;; NOTE: there are no negative numbers with this implementation,
;; so 3 - 4 should throw an error.
(define (big-subtract1 x y borrow)
  (cond
    ;; If neg, throw error
    [(< (length x) (length y))  (error "negative")]
    [(and (= 0 (length y)) (= 1 borrow))  (big-add1(list 0) y 0)]
    [(and (= 0 (length y)) (= 0 borrow))  (big-add1 x y borrow)]
    [(= 0 (length x))  (big-add1 (list borrow) y 0)]
    [else
     (append (list(neg (- (car x) (car y) borrow)))
             (big-subtract1  (cdr x) (cdr y) (bor(- (car x) (car y) borrow))))
     ]
    ))
  

(define (bor x)
 (cond [(< x 0) 1]
 [else 0])
  )

(define (neg x)
 (cond [(< x 0) (+ 1000 x)]
 [else x]))

  
;; Returns true if two big-nums are equal
(define (big-eq x y)
  (cond
    [(and (= (length x) 0) (= (length y) 0)) #t]
    [(or (< (length x) (length y)) (> (length x) (length y))) #f]
    [(= (car x)(car y)) (big-eq (cdr x) (cdr y))]
    [else
     #f
     ]))

;; Decrements a big-num
(define (big-dec x)
  (big-subtract x '(1))
  )

;; Multiplies two big-nums
(define (big-multiply x y)
  ;implement
  (cond [(or (= (car x) 0) (= (car y) 0)) (list 0)]
    [(= (car(reverse(mult-add x y 0))) 0) (reverse(cdr(reverse(mult-add x y 0))))]
        [else (mult-add x y 0)]
        )
 
    )

(define (mult-add x y co)
  (cond
    ;; If both lists are empty, the return value is either 0 or the caryover value.
    [(and (= 0 (length x)) (= 0 (length y)))
      (if >= co 0) '() (list 0)  ]
    [(= 0 (length x))  (cdr(big-add1(list co) y 0))  ]
    [(= 0 (length y))  (cdr(big-add1 x (list co) 0))  ]
    [(> (length x) (length y))
      (big-add1 (moving-add y co (car x)) (append (list 0) (mult-add y (cdr x) co)) 0)
     
     ]
    [else
      (big-add1 (moving-add x co (car y)) (append (list 0) (mult-add x (cdr y) co)) 0)
     
     ]))


  (define (moving-add lst co keep)
    (cond [(= 0 (length lst)) (list co)]
    [else (append (list(removecarry(+ (* (car lst) keep) co))) (moving-add (cdr lst) (carry(+ (* (car lst) keep) co)) keep))])
    )
  
  
;; Raise x to the power of y
(define (big-power-of x y)
  (mult-keep (car x) (car y) (car x))
  )

(define (mult-keep x y kp )
  (cond 
        [(= 2 y) (big-multiply (list x) (list kp))]
       ; [else  (mult-keep (big-multiply x kp) (list(- (car y) 1)) kp)]
        [else  (mult-keep (* x kp) (- y 1) kp)]
  )
  )

;; Dispaly a big-num in an easy to read format
(define (pretty-print x)
  (let ([lst (reverse x)])
    (string-append
     (number->string (car lst))
     (pretty-print1 (cdr lst))
     )))

(define (pretty-print1 x)
  (cond
    [(= 0 (length x))  ""]
    [else
     (string-append (pretty-print-block (car x)) (pretty-print1 (cdr x)))]
    ))

(define (pretty-print-block x)
  (string-append
   ","
   (cond
     [(< x 10) "00"]
     [(< x 100) "0"]
     [else ""])
   (number->string x)))

;; Convert a number to a bignum
(define (number->bignum n)
  (cond
    [(< n MAX_BLOCK) (list n)]
    [else
     (let ([block (modulo n MAX_BLOCK)]
           [rest (floor (/ n MAX_BLOCK))])
       (cons block (number->bignum rest)))]))

;; Convert a string to a bignum
(define (string->bignum s)
  (let ([n (string->number s)])
    (number->bignum n)))


