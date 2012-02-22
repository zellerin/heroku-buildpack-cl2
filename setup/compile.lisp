(in-package :cl-user)

(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))

(load (make-pathname :defaults *load-pathname* :name "setup"))

(ql:quickload *app-name*)

(ccl:quit)
