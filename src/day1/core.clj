(ns day1.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))


(def input (mapv #(s/split % #"   ") (line-seq (io/reader "inputday1"))))

(def left (mapv #(Integer/parseInt (first %)) input))

(def right (mapv #(Integer/parseInt (second %)) input))

(def appearances (frequencies right))


(time (reduce + (mapv #(abs (- %1 %2)) (sort left) (sort right))))

(time (reduce + (mapv #(* (get appearances % 0) %) left)))