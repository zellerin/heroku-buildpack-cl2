(in-package :wu)

(publish :path "/hello"
	 :function #'(lambda (req ent)
		       (with-http-response-and-body (req ent)
			 (html
			   (:h1 "Hello World")
			   (:princ "You're on heroku (or not)")))))

