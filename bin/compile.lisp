(in-package :cl-user)

(require :asdf)

(defvar *build-dir* (pathname-directory (pathname (concatenate 'string (asdf::getenv "BUILD_DIR") "/"))))
(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (asdf::getenv "CACHE_DIR") "/"))))
(defvar *buildpack-dir* (pathname-directory (pathname (concatenate 'string (asdf::getenv "BUILDPACK_DIR") "/"))))

(format t "XDG_CACHE_HOME: ~A~%" (asdf:getenv "XDG_CACHE_HOME"))

(load (make-pathname :directory *build-dir* :defaults "buildpack-utils.lisp"))
(add-asdf-output-translation *build-dir* (merge-pathnames "fasl/" *build-dir*))

(let ((ql-setup (make-pathname :directory (append *build-dir* '("quicklisp")) :defaults "setup.lisp")))
  (if (probe-file ql-setup)
      (load ql-setup)
      (progn
	(load (make-pathname :directory (append *buildpack-dir* '("lib")) :defaults "quicklisp.lisp"))
	(funcall (read-from-string "QUICKLISP-QUICKSTART:INSTALL")
		 :path (make-pathname :directory (pathname-directory ql-setup))))))

;;; Load the application from sources
(load (make-pathname :directory *build-dir* :defaults "heroku-setup.lisp"))
(heroku-compile)
