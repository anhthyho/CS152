#lang racket

(require racket/contract)

(struct account (balance))

(provide new-account balance withdraw deposit account)

(define (leq-than-balance? acc)
  (λ (amt)
  (cond [(> amt (account-balance acc)) #f]
        [else #t]))
  )

;; A new, empty account
(define new-account (account 0))

;; Get the current balance
(define/contract (balance acc)
  (-> account? number?)
  (account-balance acc))

;; Withdraw funds from an account
(define/contract (withdraw acc amt)
   (->i ([the-account account?]
         [the-amount (the-account)(leq-than-balance? the-account)])
        [result account?])
  (account (- (account-balance acc) amt)))

;; Add funds to an account
(define/contract (deposit acc amt)
   (->i ([the-account account?]
        [the-amount (and/c number? positive?)])
        [result account?])
  (account (+ (account-balance acc) amt)))
