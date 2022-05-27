;; ssh -p 2222 minlog@lcpt.trifon.info

;; C-x o - превключва към другия прозорец
;; C-x C-w - запише буфера във файл (save as)
;; C-x C-s - записване на файла (save)
;; C-x C-e - оценяване на израза преди курсора
;; C-c C-r - оценяване на всички изрази в избраната област
;; C-x 1 - "максимизира" текущия прозорец
;; C-x 2 - разделя хоризонтално
;; C-x 3 - разделя вертикално
;; C-x b - превключва към друг буфер
;; pp - pretty print, извежда обект на екрана
;; py - parse type
;; pt - parse term
;; pf - parse formula
;; M-w - copy
;; C-w - cut
;; C-y - paste
;; C-k - kill line, изтрива реда от курсора до края
;; C-/ - undo
;; assume (→+) - въвежда импликация и записва допускане с етикет
;; use (→-) - използва допускане
;; cdp - check and display proof
;; split (∧+)
;; C-x C-f - отваря файл (open)

(+ 2 3)
(+ 3 5)

(pp (py "alpha"))

(add-var-name "x" (py "alpha"))
(add-var-name "f" (py "alpha=>beta"))

(pp (pt "x"))
(pp (pt "f x"))

(add-pvar-name "A" (make-arity))
(add-pvar-name "B" (make-arity))
(add-pvar-name "C" (make-arity))

(pp (pf "A"))
(pp (pf "A -> B -> C"))
(pp (pf "F"))
(pp (pf "A -> F"))
(pp (pf "A & B"))
(pp (pf "A ord B"))

(set-goal (pf "A -> A"))
(assume "u")
(use "u")
(cdp)

(set-goal (pf "A -> B -> A"))
(assume "u")
(assume "v")
(use "u")
(cdp)

(set-goal (pf "(A -> B -> C) -> (A -> B) -> A -> C"))
(assume "u" "v" "w")
(use "u")
(use "w")
(use "v")
(use "w")
(cdp)

(set-goal (pf "A & B -> B & A"))
(assume "u")
;; ∧+
(split)
(use "u")
(use "u")
(cdp)

(set-goal (pf "A -> (A -> F) -> F"))
(assume "u" "v")
(use "v")
(use "u")

(set-goal (pf "(A -> C) -> (B -> C) -> A ord B -> C"))
(assume "u" "v" "w")
;; ∨-
(elim "w")

;; (assume "a")
(use "u")
;; (use "a")

;; (assume "b")
(use "v")
;; (use "b")

(set-goal (pf "A & B -> A ord B"))
(assume "u")
; ∨+0
(intro 0)
(use "u")

(set-goal (pf "A & B -> A ord B"))
(assume "u")
; ∨+1
(intro 1)
(use "u")

(set-goal (pf "((A -> F) -> F) -> A"))
(assume "u")
(use "Stab")
;; (assume "v")
(use "u")
;; (use "v")
(cdp)

(set-goal (pf "A ord (A -> F)"))

(set-goal (pf "(A & B -> F) -> (A -> F) ord (B -> F"))

(set-goal (pf "(A -> F) ord (B -> F) -> A & B -> F"))
