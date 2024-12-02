(ns day2.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))


(defn brute [coll]
  (mapv (fn [i]
          (vec (concat (subvec coll 0 i) (subvec coll (inc i)))))
        (range (count coll))))


(def input (->> (mapv #(s/split % #" ") (line-seq (io/reader "inputday2")))
                (mapv #(mapv Integer/parseInt %))))

(def bruted-input (mapv brute input))


(defn diff [vec]
  (mapv #(abs (- %1 %2)) vec (next vec)))

(defn step? [vec]
  (when (or (apply < vec) (apply > vec)) vec))

(defn too-high? [vec]
  (if (some #(< 3 %) vec) nil vec))


(->> input
     (mapv step?) 
     (mapv diff)
     (filter too-high?)
     (filter not-empty)
     (count))

(->> bruted-input
     (mapv #(filter not-empty (mapv step? %)))
     (mapv #(filter too-high? (mapv diff %)))
     (filter not-empty)
     (count))
