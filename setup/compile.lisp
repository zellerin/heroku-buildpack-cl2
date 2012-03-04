(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-dir* (butlast (pathname-directory *load-pathname*)))
(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))

(require :asdf)
(load (make-pathname :directory (append *app-dir* '("lib")) :defaults "quicklisp.lisp"))
(quicklisp-quickstart:install :path  (make-pathname :directory (append *cache-dir* '("quicklisp"))))

;(load (make-pathname :defaults *load-pathname* :name "setup"))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

(load (make-pathname :directory *app-dir* :name *app-name* :type "asd"))

(ql:quickload *app-name*)

(save-application
 (make-pathname :directory (getenv "BUILD_DIR") :name "lispapp")
 :prepend-kernel t
 :toplevel-function #'heroku-toplevel
 )

;;; +++ Belongs elsewhere, also needs to be extensible...
(defun heroku-toplevel ()
  (let ((port (parse-integer (getenv "PORT"))))
    (format t "~%Listening on port ~A" port)
    (net.aserve:start :port port)))
