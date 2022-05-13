(define i '(lambda (x) x))

(define k '(lambda (x) (lambda (y) x)))

(define s '(lambda (x)
             (lambda (y)
               (lambda (z)
                 ((x z) (y z))))))

; '(=> alpha beta)

(define tid '(=> alpha alpha))

(define base? symbol?)
(define targ cadr)
(define tres caddr)

(define var? symbol?)
(define (app? M) (and (list? M) (= 2 (length M))))
(define (abstt? M) (and (list? M) (= 3 (length M))))

(define fun car)
(define arg cadr)
(define var caadr)
(define body caddr)
  
(define app list)
(define (abstt x N) (list 'lambda (list x) N))

(define (reflect tau M)
  (if (base? tau) M
      (lambda (a)
        (let ((rho (targ tau))
              (sigma (tres tau)))
          (reflect sigma
                   (app M (reify rho a)))))))

(define (reify tau a)
  (if (base? tau) a
      (let ((x (gensym))
            (rho (targ tau))
            (sigma (tres tau)))
        (abst x (reify sigma
                       (a (reflect rho x)))))))

(define (value M xi)
  (if (var? M)
      (xi M)
      (if (app? M)
          (let ((M1 (fun M))
                (M2 (arg M)))
            ((value M1 xi)
             (value M2 xi)))
          (let ((x (var M))
                (N (body M)))
            (lambda (a)
              (value N (modify xi x a)))))))

(define (modify xi x a)
  (lambda (y)
    (if (eq? x y) a
        (xi y))))

(define (nbe tau M)
  (let ((xi (lambda (x) (reflect tau x))))
    (reify tau (value M xi))))
