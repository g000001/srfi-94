;;;; srfi-94.lisp

(cl:in-package :srfi-94.internal)
;; (in-readtable :srfi-94)

(def-suite srfi-94)

(in-suite srfi-94)


(define-function (type-error procedure . args) (apply #'error procedure args))
;@
(define-function (integer-expt x1 x2)
  (cond ((and (exact?  x1) (integer? x1)
	      (exact? x2) (integer? x2)
	      (not (and (not (<= -1 x1 1)) (negative? x2))))
	 (expt x1 x2))
	(:else (type-error 'integer-expt x1 x2))))
;@
(define-function (integer-log base k)
  (let ((n 1))
    (cl:labels ((ilog (m b k)
                  (cond ((< k b) k)
                        (:else
                         (set! n (+ n m))
                         (let ((q (ilog (+ m m) (* b b) (quotient k b))))
                           (cond ((< q b) q)
                                 (:else (set! n (+ m n))
                                        (quotient q b) ))))))
                (eigt? (k j)
                  (and (exact? k) (integer? k) (> k j)) ))
      (cond ((not (and (eigt? base 1) (eigt? k 0)))
             (type-error 'integer-log base k) )
            ((< k base) 0)
            (:else (ilog 1 base (quotient k base)) n) ))))

;;;; http://www.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/math/isqrt/isqrt.txt
;;; Akira Kurihara
;;; School of Mathematics
;;; Japan Women's University
;@
(define-function integer-sqrt
  (let ((table '#(0
		  1 1 1
		  2 2 2 2 2
		  3 3 3 3 3 3 3
		  4 4 4 4 4 4 4 4 4))
	(square (lambda (x) (* x x))) )
    (lambda (n)
      (cl:labels ((isqrt (n)
                    (if (> n 24)
                        (let* ((len/4 (quotient (- (integer-length n) 1) 4))
                               (top (isqrt (ash n (* -2 len/4))))
                               (init (ash top len/4))
                               (q (quotient n init))
                               (iter (quotient (+ init q) 2)) )
                          (cond ((odd? q) iter)
                                ((< (remainder n init)
                                    (cl:funcall square (- iter init)))
                                 (- iter 1) )
                                (:else iter) ))
                        (vector-ref table n) )))
        (if (and (exact? n) (integer? n) (not (negative? n)))
            (isqrt n)
            (type-error 'integer-sqrt n) )))))

(define-function (must-be-exact-integer2 name proc)
  (lambda (n1 n2)
    (if (and (integer? n1) (integer? n2) (exact? n1) (exact? n2))
	(cl:funcall proc n1 n2)
	(type-error name n1 n2))))
;@
(define-function quotient  (must-be-exact-integer2 'quotient #'srfi-70:quotient))
(define-function remainder (must-be-exact-integer2 'remainder #'srfi-70:remainder))
(define-function modulo    (must-be-exact-integer2 'modulo #'srfi-70:modulo))

;;;; real-only functions
;@
(define-function (quo x1 x2) (truncate (/ x1 x2)))
(define-function (rem x1 x2) (- x1 (* x2 (quo x1 x2))))
(define-function (mod x1 x2) (- x1 (* x2 (floor (/ x1 x2)))))

(define-function (must-be-real name proc)
  (lambda (x1)
    (if (real? x1) (cl:funcall proc x1) (type-error name x1))))
(define-function (must-be-real+ name proc)
  (lambda (x1)
    (if (and (real? x1) (>= x1 0))
	(cl:funcall proc x1)
	(type-error name x1))))
(define-function (must-be-real-1+1 name proc)
  (lambda (x1)
    (if (and (real? x1) (<= -1 x1 1))
	(cl:funcall proc x1)
	(type-error name x1))))
;@
(define-function ln #'log)
(define-function abs       (must-be-real 'abs #'srfi-70:abs))
(define-function real-sin  (must-be-real 'real-sin #'srfi-70:sin))
(define-function real-cos  (must-be-real 'real-cos #'srfi-70:cos))
(define-function real-tan  (must-be-real 'real-tan #'srfi-70:tan))
(define-function real-exp  (must-be-real 'real-exp #'srfi-70:exp))
(define-function real-ln   (must-be-real+ 'ln #'ln))
(define-function real-sqrt (must-be-real+ 'real-sqrt #'srfi-70:sqrt))
(define-function real-asin (must-be-real-1+1 'real-asin #'srfi-70:asin))
(define-function real-acos (must-be-real-1+1 'real-acos #'srfi-70:acos))

(define-function (must-be-real2 name proc)
  (lambda (x1 x2)
    (if (and (real? x1) (real? x2))
        (cl:funcall proc x1 x2)
        (type-error name x1 x2))))
;@
(define-function make-rectangular
  (must-be-real2 'make-rectangular #'srfi-70:make-rectangular))
(define-function make-polar
  (must-be-real2 'make-polar #'srfi-70:make-polar))

;@
(define-function real-log
  (lambda (base x)
    (if (and (real? x) (positive? x)
	     (real? base) (positive? base))
	(/ (ln x) (ln base))
	(type-error 'real-log base x))))
;@
(define-function (real-expt x1 x2)
  (cond ((and (real? x1)
	      (real? x2)
	      (or (not (negative? x1)) (integer? x2)))
	 (expt x1 x2))
	(:else (type-error 'real-expt x1 x2))))

;@
(define-function real-atan
  (lambda (y . x)
    (if (and (real? y)
	     (or (null? x)
		 (and (= 1 (cl:length x))
		      (real? (car x)))))
	(apply #'srfi-70:atan y x)
	(apply #'type-error 'real-atan y x))))

(define-function atan #'srfi-70:atan)

;;; eof
