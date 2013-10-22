module Verification


import Impression;
import Normalization;
import Initialization;
import Interaction;


public Rsl
norm(str inp) = normalize(inp, initial);


public test bool
verify01() = norm("0").wnf == Nmr(0);

public test bool
verify02() = norm("12").wnf == Nmr(12);

public test bool
verify03() = norm("false").wnf == Bln(false);

public test bool
verify04() = norm("true").wnf == Bln(true);

public test bool
verify05() = norm("(+ 1 2)").wnf == Nmr(3);

public test bool
verify06() = norm("(- 1 2)").wnf == Nmr(0);

public test bool
verify07() = norm("(* 5 3)").wnf == Nmr(15);

public test bool
verify08() = norm("(\< 3 4)").wnf != Fal;

public test bool
verify09() = norm("(\< 3 2)").wnf == Fal;

public test bool
verify10() = norm("(\> 3 2)").wnf != Fal;

public test bool
verify11() = norm("(\> 3 4)").wnf == Fal;

public test bool
verify12() = norm("(= 3 3)").wnf != Fal;

public test bool
verify13() = norm("(= 3 2)").wnf == Fal;

public test bool
verify14() = norm("(null? (list))").wnf != Fal;

public test bool
verify15() = norm("(null? (list 1 2))").wnf == Fal;

public test bool
verify16() = norm("(begin (define (swap a b) (list b a)) (swap 1 2))").wnf == Lst([Nmr(2), Nmr(1)]);

public test bool
verify17() = norm("(begin (define (* a b) (+ a b)) (* 1 2))"). wnf == Nmr(3);

public test bool
verify18() = norm("(begin (define x 1) (set! x 2) x)").wnf == Nmr(2);

public test bool
verify19() = norm("(if (\> 5 2) 10 20)").wnf == Nmr(10);

public test bool
verify20() = norm("(if (\> 2 5) 10 20)").wnf == Nmr(20);

public test bool
verify21() = norm("(begin (define (factorial n) (if (\> n 1) (* n (factorial (- n 1))) 1)) (factorial 3))").wnf == Nmr(6);

public test bool
verify22() = norm("(begin (define (length xs) (if (null? xs) 0 (+ 1 (length (tail xs))))) (length (list 1 2 3)))").wnf == Nmr(3);

public test bool
verify23() = norm("(begin (define x 1) (define (f y) (+ x y)) (set! x 2) (f 3))").wnf == Nmr(5);

public test bool
verify24() = norm("(/ 2 3)").wnf == Nmr(0);

public test bool
verify25() = norm("(% 4 3)").wnf == Nmr(1);

public test bool
verify26() = norm("(= (list 1 2) (list 1 2))").wnf == Tru;

public test bool
verify27() = norm("(\< (list) (list 1))").wnf == Tru;

public test bool
verify28() = norm("(\> (list 2 1) (list 1 2))").wnf == Tru;

public test bool
verify29() = norm("(begin (define x 1) (define (f y) (+ x y)) (define x 2) (f 3))").wnf == Nmr(5);

public test bool
verify30() = norm("(begin (define (f x) (begin (define (g y) (+ x y)) g)) (define h (f 1)) (h 2))").wnf == Nmr(3);

public test bool
verify31() = norm("(begin (define x 1) x)").wnf == Nmr(1);

public test bool
verify32() = norm("(begin (define (id x) x) (id 1))").wnf == Nmr(1);

public test bool
verify33() = norm("((+ 1) 2)").wnf == Nmr(3);

public test bool
verify34() = norm("(begin (define add1 (+ 1)) (add1 2))").wnf == Nmr(3);

