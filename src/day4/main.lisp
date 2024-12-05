(ql:quickload :serapeum)
(ql:quickload :uiop)
(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)
(ql:quickload :str)


(defun string-to-list (list) (loop :for i :to (length list)
                                   :collect (char list i)))

(defun get-uletters (cons)
    (coerce (list (nth (- (cdr cons) 1) (nth (- (car cons) 1) input))
                  (nth (+ (cdr cons) 1) (nth (+ (car cons) 1) input))) 'string))

(defun get-vletters (cons)
    (coerce (list (nth (+ (cdr cons) 1) (nth (- (car cons) 1) input))
                  (nth (- (cdr cons) 1) (nth (+ (car cons) 1) input))) 'string ))

(defun remove-every-other (list)
  (loop :for x :in list
        :for i :from 0
        :when (evenp i)
        :collect x))

(defun without-last(l)
    (reverse (cdr (reverse l))))

(defun count-xmas (list) (reduce #'+ (mapcar (lambda (x) (+ (ppcre:count-matches "XMAS" x)
                                                            (ppcre:count-matches "SAMX" x))) list)))

(defun rotate (list) (loop :for i :to (length (car list))
                           :collect (reverse (mapcar (lambda (x) (nth i x)) list))))

(defun shift (list)
    (loop :for i :to (length list)
          :collect (append (make-list i) (nth i list))))

(defun diagonate (list) 
    (loop :for i :to (+ (length list) (- (length list) 1))
          :collect (remove NIL (mapcar (lambda (x) (nth i x)) list))))


(defvar input (mapcar #'string-to-list (uiop:read-file-lines "inputday4")))

(defvar aas (remove NIL (loop :for x :in (append '("") (cdr (without-last input)) '(""))
      :for i :from 0
      :collect (mapcar (lambda (x) (cons i x)) (remove-every-other (ppcre:all-matches "(?<=.)A(?=.)" x))))))


(+ (count-xmas input)
   (count-xmas (rotate input))
   (count-xmas (diagonate (shift input)))
   (count-xmas (diagonate (shift (rotate input)))))


(reduce #'+ (mapcar (lambda (i)
    (reduce #'+ (remove NIL (mapcar (lambda (x)
        (when (or (and (string= "MS" (get-uletters x))
                       (string= "MS" (get-vletters x)))
                  (and (string= "SM" (get-uletters x))
                       (string= "SM" (get-vletters x)))
                  (and (string= "MS" (get-uletters x))
                       (string= "SM" (get-vletters x)))
                  (and (string= "SM" (get-uletters x))
                       (string= "MS" (get-vletters x))))
        1))
    i)))) aas))
