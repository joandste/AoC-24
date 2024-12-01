(ns day1.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))


(def input (map #(s/split % #"   ") (line-seq (io/reader "inputday1"))))

(def left (map #(Integer/parseInt (first %)) input))

(def right (map #(Integer/parseInt (second %)) input))


(reduce + (map #(abs (- %1 %2)) (sort left) (sort right)))

(reduce + (map (fn [x] (* (count (filter #(= x %) right)) x)) left))
