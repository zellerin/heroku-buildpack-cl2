(in-package :cl-user)

(require :asdf)

(flet ((path-from-env (path)
	 (pathname (concatenate 'string (asdf::getenv path) "/"))))
  (defvar *build-dir* (path-from-env "BUILD_DIR"))
  (defvar *cache-dir* (path-from-env "CACHE_DIR"))
  (defvar *buildpack-bin* (path-from-env "BUILDPACK_BIN")))

(defmacro fncall (funname &rest args)
  `(funcall (read-from-string ,funname) ,@args))

(defun require-quicklisp (&key version)
  "VERSION if specified must be in format YYYY-MM-DD"
  (let ((ql-setup (merge-pathnames "quicklisp/setup.lisp" *cache-dir*)))
    (if (print (probe-file (print ql-setup)))
        (load ql-setup)
        (progn
          (load (merge-pathnames "quicklisp.lisp" *buildpack-bin*))
          (fncall "quicklisp-quickstart:install"
                  :path (make-pathname :directory
				       (namestring
					(merge-pathnames "quicklisp/" *cache-dir*))))))
    (when version
      (fncall "ql-dist:install-dist"
              (format nil "http://beta.quicklisp.org/dist/quicklisp/~A/distinfo.txt"
                      version)
              :replace t :prompt nil))))

;;; stacktrace printing, copy/pasted from the ql-test by Fare:
;;; ssh://common-lisp.net/home/frideau/git/ql-test.git

(defun call-with-ql-test-context (thunk)
  (block nil
    (handler-bind (((or error serious-condition)
                     (lambda (c)
                       (format *error-output* "~%~A~%" c)
                       (return nil))))
      (funcall thunk))))

(defmacro with-ql-test-context (() &body body)
  `(call-with-ql-test-context #'(lambda () ,@body)))

(require-quicklisp)

;;; Load the application compile script
(setq *default-pathname-defaults* *build-dir*)
(with-ql-test-context ()
  (load "heroku-compile.lisp"))

(save-lisp-and-die (merge-pathnames "base.core"))
