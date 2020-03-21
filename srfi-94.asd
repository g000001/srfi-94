;;;; srfi-94.asd -*- Mode: Lisp;-*-

(cl:in-package :asdf)


(defsystem :srfi-94
  :version "20200321"
  :description "SRFI 94 for CL: Type-Restricted Numerical"
  :long-description "SRFI 94 for CL: Type-Restricted Numerical
https://srfi.schemers.org/srfi-94"
  :author "Aubrey Jaffer"
  :maintainer "CHIBA Masaomi"
  :license "MIT"
  :serial t
  :depends-on (:fiveam
               :srfi-23
               :srfi-60
               :srfi-70)
  :components ((:file "package")
               (:file "util")
               (:file "srfi-94")
               (:file "test")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-94))))
  (let ((name "https://github.com/g000001/srfi-94")
        (nickname :srfi-94))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-94))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-94#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-94)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
