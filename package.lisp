;;;; package.lisp

(cl:in-package :cl-user)
(named-readtables:in-readtable :common-lisp)

(defpackage :srfi-94
  (:use)
  (:export
   :real-exp :real-ln :real-log :real-sin :real-cos :real-tan :real-asin
   :real-acos :real-atan :atan :real-sqrt :integer-sqrt :integer-log
   :integer-expt :real-expt :quo :rem :mod :ln :make-rectangular :make-polar :abs
   :quotient :remainder :modulo))

;; (g1::delete-package* :srfi-94)
(defpackage :srfi-94.internal
  (:use :srfi-94 :named-readtables :fiveam
        :srfi-23 :srfi-60 :srfi-70)
  (:import-from :cl
                :let :let* :defun :defmacro
                :car :cdr :if :progn :list
                :nil :not
                :or :and
                :apply
                :cond
                :&allow-other-keys
                :&aux
                :&body
                :&environment
                :&key
                :&optional
                :&rest
                :&whole)
  (:shadow :modulo :remainder :quotient
           :abs :make-polar :make-rectangular
           :atan))



;;; eof
