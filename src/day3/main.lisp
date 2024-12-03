(ql:quickload :serapeum)
(ql:quickload :str)
(ql:quickload :uiop)
(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)


(defvar input (uiop:read-file-string "inputday3"))

(defvar matches (ppcre:all-matches-as-strings "mul\\(\\d+,\\d+\\)" input))

(defvar nums (mapcar (lambda (x) (ppcre:all-matches-as-strings "\\d+" x)) matches))

(defvar parsed (mapcar (lambda (x) (mapcar #'parse-integer x)) nums))


(reduce #'+ (mapcar (lambda (x) (apply #'* x)) parsed))