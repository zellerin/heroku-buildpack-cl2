(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-dir* (butlast (pathname-directory *load-pathname*)))

;;; Overridden by compile.lisp
(defvar *cache-dir* nil)

(defvar *quicklisp-home* 
  (append (or *cache-dir* *app-dir*)  '("quicklisp")))

(require :asdf)

(if (probe-file (make-pathname :directory *quicklisp-home* :defaults "setup.lisp"))
    (load (make-pathname :directory *quicklisp-home* :defaults "setup.lisp"))
    (progn
      (load (make-pathname :directory (append *app-dir* '("lib")) :defaults "quicklisp.lisp"))
;      (quicklisp-quickstart:install :path (make-pathname :directory (append *app-dir* '("quicklisp"))))
      (funcall (symbol-function (find-symbol "INSTALL" (find-package "QUICKLISP-QUICKSTART")))
	       :path (make-pathname :directory *quicklisp-home*))	       
      ))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *app-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *app-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

;(asdf:operate 'asdf:load-op "acl-compat")

(load (make-pathname :directory *app-dir* :name *app-name* :type "asd"))


