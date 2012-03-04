(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-dir* (butlast (pathname-directory *load-pathname*)))
(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))

(require :asdf)
(let ((ql-setup (make-pathname :directory (append *cache-dir* '("quicklisp")) :defaults "setup.lisp")))
  (if (probe-file ql-setup)
      (load ql-setup)
      (progn
	(load (make-pathname :directory (append *app-dir* '("lib")) :defaults "quicklisp.lisp"))
	(funcall (symbol-function (find-symbol "INSTALL" (find-package "QUICKLISP-QUICKSTART")))
		 :path (make-pathname :directory (pathname-directory ql-setup))))))

;(load (make-pathname :defaults *load-pathname* :name "setup"))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

(load (make-pathname :directory *app-dir* :name *app-name* :type "asd"))

(ql:quickload *app-name*)

;;; +++ Belongs elsewhere, also needs to be extensible...
(defun heroku-toplevel ()
  (let ((port (parse-integer (getenv "PORT"))))
    (format t "Listening on port ~A~%" port)
    (net.aserve:start :port port)
    (loop (sleep 60))			;sleep forever
    ))

(save-application
 (format nil "~A/bin/lispapp" (getenv "BUILD_DIR")) ;must match path specified in bin/release
 :prepend-kernel t
 :toplevel-function #'heroku-toplevel
 )
