(in-package :cl-user)

(require :asdf)

(flet ((path-from-env (path)
	 (pathname (concatenate 'string (asdf::getenv path) "/"))))
  (defvar *build-dir* (path-from-env "BUILD_DIR"))
  (defvar *cache-dir* (path-from-env "CACHE_DIR"))
  (defvar *buildpack-bin* (path-from-env "BUILDPACK_BIN")))

(defun require-quicklisp (&key version)
  "VERSION if specified must be in format YYYY-MM-DD"
  (let ((ql-setup (merge-pathnames "quicklisp/setup.lisp" *cache-dir*)))
    (cond
      ((probe-file ql-setup)
       (load ql-setup))
      (t
          (load (merge-pathnames "quicklisp.lisp" *buildpack-bin*))
          (funcall (find-symbol "INSTALL" 'quicklisp-quickstart)
                  :path (make-pathname :directory
				       (namestring
					(merge-pathnames "quicklisp/" *cache-dir*))))))
    (when version
      (funcall (find-symbol "INSTALL-DIST" 'ql-dist)
              (format nil "http://beta.quicklisp.org/dist/quicklisp/~A/distinfo.txt"
                      version)
              :replace t :prompt nil))))

(require-quicklisp)

;;; Load the application compile script
(setq *default-pathname-defaults* *build-dir*)
(handler-case
    (progn
      (load "heroku-compile.lisp")
      (save-lisp-and-die (merge-pathnames "base.core")))
  (error (e)
    (format t "Compilation failed: ~a" e)))
