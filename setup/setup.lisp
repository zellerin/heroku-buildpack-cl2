(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-home* (butlast (pathname-directory *load-pathname*)))

(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))

(require :asdf)



(if (probe-file (make-pathname :directory (append *app-home* '("quicklisp")) :defaults "setup.lisp"))
    (load (make-pathname :directory (append *app-home* '("quicklisp")) :defaults "setup.lisp"))
    (progn
      (load (make-pathname :directory (append *app-home* '("lib")) :defaults "quicklisp.lisp"))
;      (quicklisp-quickstart:install :path (make-pathname :directory (append *app-home* '("quicklisp"))))
      (funcall (symbol-function (find-symbol "INSTALL" (find-package "QUICKLISP-QUICKSTART")))
	       :path (make-pathname :directory (append *app-home* '("quicklisp"))))	       
      ))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

;(asdf:operate 'asdf:load-op "acl-compat")

(load (make-pathname :directory *app-home* :name *app-name* :type "asd"))


