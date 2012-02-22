(in-package :cl-user)

(load (make-pathname :defaults *load-pathname* :name "setup"))

(ql:quickload *app-name*)

(let ((port (or (ignore-errors (parse-integer (getenv "PORT")))
			    3000)))
  (format t "~%Listening on port ~A" port)
  (net.aserve:start :port port))

