(cl:in-package :srfi-94.internal)
;; (in-readtable :srfi-94)

(def-suite srfi-94)

(in-suite srfi-94)

(defmacro e? (&body body)
  `(signals (cl:error)
     ,@body))

(test real-foo
  (let ((n #c(1 1)))
    (e? (real-exp n))
    (e? (real-log n))
    (e? (real-sin n))
    (e? (real-cos n))
    (e? (real-tan n))
    (e? (real-asin n))
    (e? (real-acos n))
    (e? (real-atan n))
    (e? (atan n n))))

(test real-sqrt
  (e? (real-sqrt -8))
  (e? (real-sqrt #c(1 1)))
  (e? (integer-sqrt -8))
  (e? (integer-sqrt #c(1 1))))

(test integer-log
  (e? (integer-log 10 -2))
  (e? (integer-log 10 2.0)))

(test integer-expt
  (e? (integer-expt 0 3.0)))

(test real-expt
  (e? (real-expt 0.0 #c(1 1))))

(test quo
  (for-all ((x1 (gen-integer))
            (x2 (gen-integer)) )
    (is-true (= x1 (+ (* x2 (quo x1 x2))
                      (rem x1 x2) ))))
  (is (= 3 (quo 2/3 1/5)))
  (is (= 3.0 (quo .666 1/5)))
  (is (= (mod .666d0 1/5)
         0.06599999999999995d0)))

;;; eof
