(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-home* (butlast (pathname-directory *load-pathname*)))

(require :asdf)

(load (make-pathname :directory (append *app-home* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

(if (probe-file (make-pathname :directory (append *app-home* '("quicklisp")) :defaults "setup.lisp"))
    (load (make-pathname :directory (append *app-home* '("quicklisp")) :defaults "setup.lisp"))
    (progn
      (load (make-pathname :directory (append *app-home* '("lib")) :defaults "quicklisp.lisp"))
;      (quicklisp-quickstart:install :path (make-pathname :directory (append *app-home* '("quicklisp"))))
      (funcall (symbol-function (find-symbol "INSTALL" (find-package "QUICKLISP-QUICKSTART")))
	       :path (make-pathname :directory (append *app-home* '("quicklisp"))))	       
      ))


(load (make-pathname :directory *app-home* :name *app-name* :type "asd"))


