#lang racket
(provide sumofsquares1 sumofsquares2 join-strings make-html-tags)

;; Given a list of numbers, produce the sum of their squares. 
;; Use foldr, not recursion.
(define (sumofsquares1 lst)
   (foldr +  0 (map (lambda (x)(* x x)) lst))
)

;; Repeat with foldl
(define (sumofsquares2 lst)
   (foldl +  0 (map (lambda (x)(* x x)) lst))
  )

;; Using foldl, combine a list of strings into a single string,
;; separated by the specified separator.  Separators should only
;; appear between words
(define (join-strings list-of-strings separator)
    (foldl string-append ""
    (map (lambda (x)
           (cond [(eq? x (car (reverse list-of-strings)))(string-append x "")]
                 [(eq? x "")(string-append x "")]
                 [else (string-append x separator)]))
           (reverse list-of-strings)))
)

;; Make matching open and close tags, using the list of tag-names
(define (make-html-tags tag-names)
  (string-append
   (foldl string-append ""
    (map (lambda (x)(string-append "<" (string-append x ">")))
           (reverse tag-names)))
   (foldr string-append ""
    (map (lambda (x)(string-append "</" (string-append x ">")))
           (reverse tag-names))))
)

(define (make-html-tags2 tag-names)
  (foldl string-append ""
    (map (lambda (x)(string-append "<" (string-append x ">")))
           (reverse tag-names)))
)

(join-strings '("hi" "you" "all") " ")
(join-strings '("" "617" "555" "6792") "-")
(make-html-tags '("body" "div" "table" "tr" "td"))
