#lang racket

;Defines list
;(define start(list -1 -1 -1 -1 1 1 1 1))

;This removes the duplicates and creates permutations
;(define perms (remove-duplicates (permutations start)))

;Here two 1s are added to the front of the list and then -1 to the end of the list
;1 representa a number whereas -1 represents an operator
;(define (to-rpn l)
 ;(append (list 1 1) l (list -1)))

;(map to-rpn perms)

;Defines list of 6 numbers
;(define numbers (list 100 50 10 6 5 1))

;Returns a list of all permutations of the input list
;(permutations numbers) ;This function works without inspecting the elements and therefore ignores repeated elements which will result in repeated permutations

;Defines list of operations needed
;(define ops ( list '+ '- '* '/)) ; ' = Tells to use symbol not function

;Computes the cartesian product of the given list
;(cartesian-product ops ops ops ops ops)


;Defining the list of numbers used to calculate the sum
(define numbers(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

;Outputs list of numbers defined above
numbers

;Random number generator that generates a number between the max and the min which is 100 to 1000
(define rand(random 101 1000))

;Outputs random number between 100 and 1000 with Targer label
(write 'Target:) rand

;This creates an empty list to hold the 6 numbers chosen from the new list of numbers
(define numChosen (list))

(define select4Numbers (list));Creates list for selecting 4 numbers
(define (randomListNumbers l);Creates list for random numbers  
  (define randomNumber(list-ref l(random (length l))));Defines random number, refers to list
  (set! l(remove randomNumber l))
  (set! select4Numbers (cons randomNumber select4Numbers));
  (if (= (length select4Numbers) 4);If the length of the select4Numbers list is 4
     select4Numbers ;Prints 4 random numbers
      (randomListNumbers l));Move to this list
)
(randomListNumbers numbers);Outputs random list


(define select2Numbers (list));Creates list for selecting 2 numbers
(define (randomListNumbers2 r);Creates list for random numbers  
  (define randomNumber(list-ref r(random (length r))));Defines random number, refers to list 
  (set! r(remove randomNumber r)) 
  (set! select2Numbers (cons randomNumber select2Numbers))  
  (if (= (length select2Numbers) 2);If the length of the select4Numbers list is 2
     select2Numbers ;Prints 2 random numbers
      (randomListNumbers2 r));Move to this list
)
(randomListNumbers2 numbers);Outputs second random list

;Defines list of operations needed
(define ops ( list '+ '- '* '/)) ; ' = Tells to use symbol not function

(define select4Ops (list));Creates list for selecting 3 operations
(define (randomListOps r);Creates list for random operations  
  (define randomOp(list-ref r(random (length r))));Defines random operator, refers to list
  (set! r(remove randomOp r)) 
  (set! select4Ops (cons randomOp select4Ops))  
  (if (= (length select4Ops) 4);If the length of the select4Ops list is 4
     select4Ops ;Prints 3 random operations
      (randomListOps r));Move to this list
)
(randomListOps ops);Outputs random operation list

(define selectOp (list));Creates list for selecting 3 random operations
(define (randomListOp r);Creates list for random operations 
  (define randomOp(list-ref r(random (length r))));Defines random operator, refers to list 
  (set! r(remove randomOp r)) 
  (set! selectOp (cons randomOp selectOp))  
  (if (= (length selectOp) 1);If the length of the selectOp list is 1
     selectOp ;Prints 1 random operation
      (randomListOp r));Move to this list
)
(randomListOp ops);Outputs second random operation list

;Merging lists
(define perms(remove-duplicates (permutations (append select4Numbers select4Ops)))); select4Ops select2Numbers selectOp))))
;perms;Output list

;Used to calculate RPN, taken from https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket
(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
    (printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
       [('/ (list x y s ___)) (if (= y 0)
                                (cons 0 s)
                                (if (= x 0)
                                    (cons 0 s)
                                    (cons (/ x y) s)))]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))


;Applies function from above to each element of the list which in turn gets the valid rpn
(define (valid-rpn? e (s 0)) ;default value is 0, s=stack
  (if (null? e);If null is not e
      (if (= s 1) #t #f);If stack =1
      (if (number? (car e));If the first thing on the list is a number
          (valid-rpn? (cdr e) (+ s 1));Add one to the stack if its a valid rpn
      (if (> s 1);If s is less than 1
          (valid-rpn? (cdr e) (- s 1));Take 1 off the stack
          #f)))) ;true ot false

;Function to make a perm into a rpn expression and calculates the expression if valid rpn
;(define (rpn-selected-numbers) list)
;(define (rpn-selected-operators) list)

(define (toRPN l);Defining toRPN list
  (cond [(valid-rpn? (append select2Numbers l selectOp));(Condition)If it's a valid RPN join the lists
   (calculate-RPN (append select2Numbers l selectOp))]));Calculate the RPN of the joined lists
(map toRPN perms);Maps toRPN to perms list














