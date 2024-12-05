(ns day2.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))


(defn brute [coll] 
  (for [i (range (count coll))]
    (vec (concat (subvec coll 0 i) (subvec coll (inc i))))))


(def input (->> (mapv #(s/split % #" ") (line-seq (io/reader "input/day2")))
                (mapv #(mapv Integer/parseInt %))))

(def bruted-input (mapv brute input))


(defn diff [coll]
  (mapv #(abs (- %1 %2)) coll (next coll)))

(defn step? [coll]
  (when (or (apply < coll) (apply > coll)) coll))

(defn too-high? [coll]
  (if (some #(< 3 %) coll) nil coll))


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
