(in-package :cl-user)

(defvar *app-dir* (butlast (pathname-directory *load-pathname*)))
(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))
(defvar *buildpack-dir* (pathname-directory (pathname (concatenate 'string (getenv "BUILDPACK_DIR") "/"))))

(require :asdf)
(let ((ql-setup (make-pathname :directory (append *cache-dir* '("quicklisp")) :defaults "setup.lisp")))
  (if (probe-file ql-setup)
      (load ql-setup)
      (progn
	(load (make-pathname :directory (append *buildpack-dir* '("lib")) :defaults "quicklisp.lisp"))
	(funcall (symbol-function (find-symbol "INSTALL" (find-package "QUICKLISP-QUICKSTART")))
		 :path (make-pathname :directory (pathname-directory ql-setup))))))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

;;; Default toplevel, app can redefine if necessary
(defun heroku-toplevel ()
  (let ((port (parse-integer (getenv "PORT"))))
    (format t "Listening on port ~A~%" port)
    (net.aserve:start :port port)
    (loop (sleep 60))			;sleep forever
    ))

;;; This loads the application
(load (make-pathname :directory *app-dir* :defaults "heroku-setup.lisp"))

(save-application
 (format nil "~A/bin/lispapp" (getenv "BUILD_DIR")) ;must match path specified in bin/release
 :prepend-kernel t
 :toplevel-function #'heroku-toplevel
 )
