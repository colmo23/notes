# Cider

M-x   cider
C-u CM-x
\#debug   - add breakpoint

## Debugger commands:

n  - next
i - step in fn
o - step up
c - continue



## Cider commands

M-x cider-jack-in  Start lein

C-e		Go to end of line

C-x C-e		Run current line in repl

C-c M-n M-n     Sets the namespace to the namespace listed at the top of your current file

                after this you can call any functions in the repl

C-c C-k 	Compile file

C-up arrow      Cycle thru history in repl

q		quit error window

C-c C-d C-d     Print documentation for symbol under point

C-c C-d C-a     Search for text across function names and documentation


M-x paredit-mode   Toggle paredit mode on/off

M-(             Encode in brackets in paredit mode

C-left arrow, right arrow  Slurp, barf elements of a list

C-M-f           Go to closing bracket

C-M-b		Go to opening bracket

CM-x		Evaluate the current expression

C-u CM-x        Evaluate the current experssion in a debugger

\#break          Add this in code to start debugging from CM-x evaluation session

# Clojure

operation - (operator operand1 operand2 ...) - eg:
```
(+ 1 2 3) 
(if bool
 then-form
 optional-else-form)
(if bool
 (do (first-thing)
  second-thing))
(when bool
   (first-thing)
   second-thing)
(nil? 1)
(= 1 1) - equality check
(or a b c) - return first true value or the last value
(and a b c) - return first false value or the last value
(def abc "value") - assign "value" to abc
(str "one " "two")  - append strings
{:key1 value1 key2: value2} - map. key and value can be any type
(hash-map :a 1 :b 2) - create a map
(get {:a 0 :b 1} :b) - lookup map by key
(get {:a 0 :b 1} :c "unicorns?") - return default value if no key exists
(get-in {:a 0 :b {:c "ho hum"}} [:b :c]) - lookup value in nested map
({:name "The Human Coffeepot"} :name) - alternative to get
[3 2 1] - a vector - similar to an array
(get [3 2 1] 0) - get the first entry
(vector "creepy" "full" "moon") - create vector
(conj [1 2 3] 4) add entry to end of vector
(into [1 2] [4 5]) join 2 vectors
(count [1 2 3])  - number of elements in list
'(1 2 3)   - define a list
(nth '(:a :b :c) 0)    -get the first element of a list
(list 1 2 3)  - create a list
(conj '(1 2 3) 4) - 4 is added to start of list
#{"kurt vonnegut" 20 :icicle}   - a set - a collection of unique elements
(hash-set 1 1 2 2)   - create another set
(set [3 3 3 4 4]) - create a set from a list
(contains? #{:a :b} :a) - check if a set contains an element
```

## Calling a function: (operation operand1 operand2 ...)
```
(defn my-function
   "optional doc string"
   [arg1 arg2 & other-args]
   (map + arg1 arg2))
```
## Function example with different arities:
```
(defn x-chop
  "Describe the kind of chop you're inflicting on someone"
  ([name chop-type]
     (str "I " chop-type " chop " name "! Take that!"))
  ([name]
     (x-chop name "karate")))   (str "hello " name))
```
## Anonymouns function:
```
(fn [name] (str "Hi, " name))
```
Compact function "%" is the argumen
```
#(* % 3)
```
Two argumaents
```
#(* %1 %2)
```


```
(re-find #"^left-" "left-eye")
```
Look from 10 to 0:
```
(loop [x 10]            
  (when (> x 1)
    (println x)
    (recur (- x 2))))     
```

```
 (let [[new-var & other-var-list] original-list])

(def sum #(reduce + %))
(reduce fn list)    - fn must take 2 arguments. fn is called with the first 2 elements of list. fn is then applied on the result and the next arg, etc

(conj seq val1 val2)    - add a values to a seq
(into [] (map inc [1 2 3)    - convert a seq returned my map to a list. also works for {} and #{}

(map fn <list>)  - call fn on each element of list and return a new list
(map fn <list> <list>) call fh on each pair of elements for the lists and return new list
(map #(% numbers) [fn1 fn2])   - call a list of functions on a list
(map :my-key [my-map])          - extract a list of values from a list of maps based on key

(reduce fn [1 2 3]) - Convert list to a value. Call fn on each element of a list

(assoc {:a 1} :b 2)  - add or replace a new key, value to a map

(take 3 [1 2 3 4 5 6 7 8 9 10]) - return first 3 elements from list

(drop 3 [1 2 3 4 5 6 7 8 9 10]) - return list minus the first 3 elements

(take-while fn list) - return element of list while the elements of list satisfy fn, eg:
(take-while #(> % 10) [11 12 13 9 20])

(drop-while #(> % 13) [11 12 
13 9 20])

(filter fn list)  - return the elements of the list that return true when called by the function

(some fn list)   - returns the first element of list that returns true for list

(sort list) - returns sorted list

(sort-by fn list)  - sort a list by the value of the element returned by fn

(concat list1 list2) - appends one seq to another

(first list) - get the first element
(next list)   - get everything but the first eleaman

(repeat "1")   - create an infinite seq of repeated "1"

(repeatedly fn) - create an infinite seq of the return value of a function

```
Return infinite seq of even numbers - lazy-seq stop a stack overflow error
```
(defn even-numbers
  ([] (even-numbers 0))
  ([n] (cons n (lazy-seq (even-numbers (+ n 2))))))
```

```
(max 0 1 2)  - max function takes variable args
(apply max [0 1 2])  - apply allows a list to be passed to the function max

(def add10 (partial + 10))

(into [1 2] #{4 3})  - add RHS elements to data structure on LHS

(def mm {1 "car" 2 "house"})                                                                         |
(def mm2 (assoc mm 3 "bike"))   - create new map with an additional key value entry

(def mulinc (comp #(* 2 %) *))  - comp - make one function out of 2

(require '[clojure.string :as str])
(int "j")  # get integer value of str

(format "%s %d" "a string" 10)
(apply str ["a" "b"])   # convert the vector into a list of arguments to be passed to a function
(interpose "-" "my string") - creates a seq with "-" between each element
(clojure.string/split string #"\n")
(re-seq #"\d+" "numbers 1 3 3") # extracts a list of regex matches

(str/replace "a b" #"\s+" ".")  # replace spaces with "."s
(str/split "a b c" "\s+")    # split string into list

(name :keyword)  # converts keyword to a string "keyword"

(Integer/parseInt "-42")
(bigdecimal "333.33")      # convert to decimal type
```

### loop through a sequence:
```
(doseq [x [1 2 3]]                                                                                    |
  (println x)                                                                                           |
)
```

```
(-main "-h")    # run main from the repl
```

## Typical dependencies
```
[lein-ancient "0.6.15"]
        [lein-cljfmt "0.6.7"]
        [lein-kibit "0.1.8"]
            [jonase/eastwood "0.3.10"]
        [lein-bikeshed "0.5.2"]
            [lein-shell "0.5.0"]

lein eastwood  # lint tool
lein cljfmt fix  # format code
lein bikeshed  # lint tool
lein kibit # lint tool
lein ancient # check for outdated artifacts
```
