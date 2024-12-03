(ql:quickload :serapeum)
(ql:quickload :str)
(ql:quickload :uiop)
(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)
(ql:quickload :arrow-macros)


(defvar input (uiop:read-file-string "inputday3"))

(defvar matches (ppcre:all-matches-as-strings "mul\\(\\d+,\\d+\\)|do\\(\\)|don't\\(\\)" input))


(defun check-enabled (coll)
  (let ((enabled? T))
    (loop :for x :in coll
     :collect (cond ((and enabled? (not (or (string= x "do()") (string= x "don't()")))) x)
                    ((and enabled? (string= x "don't()")) (setq enabled? NIL) NIL)
                    ((and (not enabled?) (string= x "do()")) (setq enabled? T) NIL)))))


(arrow-macros:->> matches 
  (check-enabled)
  (remove NIL)
  (mapcar (lambda (x) (ppcre:all-matches-as-strings "\\d+" x)))
  (mapcar (lambda (x) (mapcar #'parse-integer x)))
  (mapcar (lambda (x) (apply #'* x)))
  (reduce #'+))
