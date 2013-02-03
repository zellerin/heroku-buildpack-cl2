(in-package :cl-user)

(defvar *build-dir* (pathname-directory (pathname (concatenate 'string (getenv "BUILD_DIR") "/"))))
(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))
(defvar *buildpack-dir* (pathname-directory (pathname (concatenate 'string (getenv "BUILDPACK_DIR") "/"))))

;;; Tell ASDF to store binaries in the cache dir
(ccl:setenv "XDG_CACHE_HOME" (concatenate 'string (getenv "BUILD_DIR") "/.asdf/"))

(require :asdf)

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
