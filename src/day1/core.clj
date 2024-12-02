(ns day1.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))


(def input (mapv #(s/split % #"   ") (line-seq (io/reader "inputday1"))))

(def left (sort (mapv #(Integer/parseInt (first %)) input)))

(def right (sort (mapv #(Integer/parseInt (second %)) input)))

(def appearances (frequencies right))


(reduce + (mapv #(abs (- %1 %2)) left right))

(reduce + (mapv #(* (get appearances % 0) %) left))