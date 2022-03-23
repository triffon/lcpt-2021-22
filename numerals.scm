(define (repeated n f x)
  (if (= n 0) x
      (f (repeated (- n 1) f x))))
      ; !!! (lambda (f x)

(define (c n)
  (lambda (f)
    (lambda (x)
      (repeated n f x))))

(define 1+ (lambda (x) (+ x 1)))

(define (printn c)
  ((c 1+) 0))

(define c0 (c 0))
(define c1 (c 1))
(define c2 (c 2))
(define c5 (c 5))
(define c8 (c 8))

(define cs
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

(define c+
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (lambda (x)
          ((m f) ((n f) x)))))))

(define c++
  (lambda (m)
    (lambda (n)
      ((m cs) n))))

(define c*
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (m (n f))))))

(define c**
  (lambda (m)
    (lambda (n)
      ((m (c+ n)) c0))))

(define c^^
  (lambda (m)
    (lambda (n)
      ((n (c* m)) c1))))

(define c^
  (lambda (m)
    (lambda (n)
      (n m))))

(define ci
  (lambda (n)
    ((n cs) c0)))

(define c#t
  (lambda (x)
    (lambda (y)
      x)))

(define c#f
  (lambda (x)
    (lambda (y)
      y)))

(define (printb b)
  ((b #t) #f))

(define cif c1)

(define cnot
  (lambda (b)
    (lambda (x)
      (lambda (y)
        ((b y) x)))))

(define cand
  (lambda (p)
    (lambda (q)
      (lambda (x)
        (lambda (y)
          ((p ((q x) y)) y))))))

(define candd
  (lambda (p)
    (lambda (q)
      ((p q) c#f))))

(define cor
  (lambda (p)
    (lambda (q)
      ((p c#t) q))))

(define c=0
  (lambda (n)
    ((n (lambda (q) c#f)) c#t)))

(define c/2
  (lambda (n)
    ((n cnot) c#t)))
