(ql:quickload :str)
(ql:quickload :uiop)


;; parsing test
(mapcar (lambda (x) (str:split "   " x)) (uiop:read-file-lines "inputday1"))