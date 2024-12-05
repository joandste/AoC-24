(ql:quickload :serapeum)
(ql:quickload :uiop)
(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)


(defvar input (uiop:read-file-string "input/day3"))

(defvar part1 (ppcre:all-matches-as-strings "mul\\(\\d+,\\d+\\)" input))

(defvar part2 (ppcre:all-matches-as-strings "mul\\(\\d+,\\d+\\)|do\\(\\)|don't\\(\\)" input))


(defun check-enabled (coll)
  (let ((enabled? T))
    (loop :for x :in coll
     :collect (cond ((and enabled?
                          (not (or (string= x "do()")
                                   (string= x "don't()"))))
                           x)
                    ((and enabled?
                          (string= x "don't()"))
                           (setq enabled? NIL) NIL)
                    ((and (not enabled?)
                          (string= x "do()"))
                           (setq enabled? T) NIL)))))


(time (serapeum:~>> part1
  (mapcar (lambda (x) (ppcre:all-matches-as-strings "\\d+" x)))
  (mapcar (lambda (x) (mapcar #'parse-integer x)))
  (mapcar (lambda (x) (apply #'* x)))
  (reduce #'+)))

(time (serapeum:~>> part2
  (check-enabled)
  (remove NIL)
  (mapcar (lambda (x) (ppcre:all-matches-as-strings "\\d+" x)))
  (mapcar (lambda (x) (mapcar #'parse-integer x)))
  (mapcar (lambda (x) (apply #'* x)))
  (reduce #'+)))
