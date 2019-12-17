#lang racket
(struct employee (fname lname salary))
(struct manager (fname lname salary bonus))
(struct boss (fname lname salary))

(define (calc-wages emp)
  (match emp
    ; _ acts as a placeholder (dc about what the value is)
    [(struct employee (_ _ sal)) sal]
    [(struct manager (_ _ sal bonus)) (+ sal bonus)]
    [(struct boss (_ _ sal)) (* sal 10)])
  )

(let ([dillbert (employee "Dillbert" "Adams" 80000)]
      [gillbert (manager "Gillbert" "Adams" 85000 1200)]
      [ponty (manager "Ponty" "Nani" 100000 25000)]
      [baws (boss "baws" "beep" 123456789)])
  (displayln(calc-wages dillbert))
  (displayln(calc-wages gillbert))
  (displayln (calc-wages ponty))
  (displayln(calc-wages baws)))

