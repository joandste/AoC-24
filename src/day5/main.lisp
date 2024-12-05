(ql:quickload :serapeum)
(ql:quickload :uiop)
(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)

(defvar input (uiop:read-file-lines "inputday5"))

(defvar rules (loop :for i :from 0 :to 1175
                    :collect (ppcre:all-matches-as-strings "\\d+" (nth i input))))

(defvar pages (loop :for i :from 1177 :to 1380
                    :collect (ppcre:all-matches-as-strings "\\d+" (nth i input))))


;; optimaly something like (mapcar (functionbuilder rules) pages)
