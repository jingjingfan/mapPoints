;;; testPoints.rkt
;;;
;;; REQUIRED FILES:
;;;       - pip.rkt
;;;       - neighborhoodPoly.rkt (can be generated through index.js)
;;;
;;; Input-File: test_points.txt
;;; Output: points and any neighborhood it's in
;;;
;;; Process test points to be plug into Point in Polygon calculation
;;;

#lang racket
(require "pip.rkt")
(require "neighborhoodPoly.rkt")


;;
;; Reading and parsing input-file
;;
(define (truncate line)
  (string-split (list-ref (string-split line ":") 1) ","))

(define (toNum line)
  (point (string->number (string-trim (list-ref line 0))) (string->number (list-ref line 1))))

(define test-point-list '() )

(define (make-list pt)
  (set! test-point-list (list* pt test-point-list)))

;; reading file and converting points into coord stored in a test-point-list
(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
       (make-list (toNum (truncate line)))
      (next-line-it file))))

(call-with-input-file "test_points.txt" next-line-it)


;;
;; Invoking PIP calculation with test-point-list & JS generated polygon
;;
(define (test-neigh point hoods)
  (for ([n hoods])
    (when (point-in-polygon? point (neighborhood-segs n))
      (printf "~a" (neighborhood-name n))
    )))

(define (test-figure points neighborhoods)
  (for ([p points]
        [i (length points)])
    (printf "\nPoint ~v: " (+ i 1)) (test-neigh p neighborhoods))
    )

(test-figure (reverse test-point-list) listOfNeighborhood)


  