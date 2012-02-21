(in-package :cl-user)

(net.aserve:publish :path "/hello"
		    :function #'(lambda (req ent)
				  (net.aserve:html
				   (:h1 "Hello World")
				   (:princ "You're on heroku (or not)"))))

