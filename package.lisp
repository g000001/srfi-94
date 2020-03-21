;;;; package.lisp

(cl:in-package common-lisp-user)


(defpackage "https://github.com/g000001/srfi-94"
  (:use)
  (:export
   real-exp real-ln real-log real-sin real-cos real-tan real-asin
   real-acos real-atan atan real-sqrt integer-sqrt integer-log
   integer-expt real-expt quo rem mod ln make-rectangular make-polar abs
   quotient remainder modulo))


(defpackage "https://github.com/g000001/srfi-94#internals"
  (:use
   "https://github.com/g000001/srfi-23"
   "https://github.com/g000001/srfi-60"
   "https://github.com/g000001/srfi-70"
   "https://github.com/g000001/srfi-94"
   fiveam)
  (:import-from common-lisp
   let let* defun defmacro car cdr if progn list nil not or and apply
   cond &allow-other-keys &aux &body &environment &key &optional &rest
   &whole)
  (:shadow modulo remainder quotient abs make-polar make-rectangular atan))


;;; *EOF*
