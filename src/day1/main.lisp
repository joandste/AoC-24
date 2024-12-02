(ql:quickload :serapeum)
(ql:quickload :str)
(ql:quickload :uiop)


(defvar input (mapcar (lambda (x) (mapcar #'parse-integer (str:split "   " x))) (uiop:read-file-lines "inputday1")))

(defvar left (sort (mapcar #'car input) #'<))

(defvar right (sort (mapcar #'cadr input) #'<))

(defvar appearances (serapeum:frequencies right))


(reduce #'+ (mapcar (lambda (l r) (abs (- l r))) left right))

(reduce #'+ (mapcar (lambda (l) (* (gethash l appearances 0) l)) left))
