;;; Point in Polygon Calculation Module using Ray Casting.
;;; Source - rosettacode
;;; Ray casting method calculates how many times segs of polygon has bene crossed
;;; by the horizontal ray starting from given point. Result is determined by the odd
;;; and even number of intersection of segments.
;;;
(module pip racket
  (require racket/contract)
 
  (provide point)
  (provide seg)
  (provide (contract-out [point-in-polygon? (-> 
                                             point? 
                                             list? 
                                             boolean?)]))
 
  (struct point (x y) #:transparent)
  (struct seg (Ax Ay Bx By) #:transparent)
  (define ε 0.000001)
  (define (neq? x y) (not (eq? x y)))
 
  (define (ray-cross-seg? r s)
    (let* ([Ax (seg-Ax s)] [Ay (seg-Ay s)]
           [Bx (seg-Bx s)] [By (seg-By s)]
           [Px (point-x r)] [Pyo (point-y r)]
           [Py (+ Pyo (if (or (eq? Pyo Ay) 
                              (eq? Pyo By)) 
                          ε 0))])
 
      (define Ax2 (if (< Ay By) Ax Bx))
      (define Ay2 (if (< Ay By) Ay By))
      (define Bx2 (if (< Ay By) Bx Ax))
      (define By2 (if (< Ay By) By Ay))
 
      (cond [(or (> Py (max Ay By)) (< Py (min Ay By))) #f]
            [(> Px (max Ax Bx)) #f]
            [else (cond 
                [(< Px (min Ax Bx)) #t]
                [else
                 (let ([red (if (neq? Ax2 Bx2)
                               (/ (- By2 Ay2) (- Bx2 Ax2))
                               +inf.0)]
                      [blue (if (neq? Ax2 Px)
                                (/ (- Py Ay2) (- Px Ax2))
                                 +inf.0)])
                   (if (>= blue red) #t #f))])])))
 
  (define (point-in-polygon? point polygon)
    (odd? 
     (for/fold ([c 0]) ([seg polygon])
       (+ c (if (ray-cross-seg? point seg) 1 0))))))
