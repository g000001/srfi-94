;;;; srfi-94.asd -*- Mode: Lisp;-*-

(cl:in-package :asdf)

(defsystem :srfi-94
  :serial t
  :depends-on (:fiveam
               :named-readtables
               :srfi-23
               :srfi-60
               :srfi-70)
  :components ((:file "package")
               (:file "util")
               (:file "srfi-94")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-94))))
  (load-system :srfi-94)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-94.internal :srfi-94))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
