(in-package :cl-user)

(load (make-pathname :defaults *load-pathname* :name "setup"))

(ql:quickload *app-name*)

(net.aserve:start :port (or (ignore-errors (parse-integer (getenv "PORT")))
			    3000))

