(in-package :cl-user)

;;; Customize

(defvar *app-name* "example")

;;; Standard

(defvar *app-dir* (butlast (pathname-directory *load-pathname*)))

(require :asdf)
(load (make-pathname :directory (append *app-dir* '("lib")) :defaults "quicklisp.lisp"))

(defvar *cache-dir* (pathname-directory (pathname (concatenate 'string (getenv "CACHE_DIR") "/"))))

;(load (make-pathname :defaults *load-pathname* :name "setup"))

(asdf:clear-system "acl-compat")

(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "acl-compat"))
		     :defaults "acl-compat.asd"))
(load (make-pathname :directory (append *cache-dir* '("repos" "portableaserve" "aserve"))
		     :defaults "aserve.asd"))

(load (make-pathname :directory *app-dir* :name *app-name* :type "asd"))

(ql:quickload *app-name*)

(save-application
 (make-pathname :directory (getenv "BUILD_DIR") :name *app-name* :type "app")
; :toplevel-function
 )
