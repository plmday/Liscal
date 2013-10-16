module Internalization


import Prelude;
import Expression;
import Impression;


public Imp
internalize(str inp) = build(parse(#Exp, inp));


public Imp
build((Exp) `<Dec digs>`) = Nmr(toInt("<digs>"));

public Imp
build((Exp) `<Idr chrs>`) {
  switch ("<chrs>") {
    case "false": return Bln(false);
    case "true" : return Bln(true);
    default: return Smb("<chrs>");
  }
}

public Imp
build((Exp) `(<Exp* exps>)`) = Lst([build(exp) | exp <- exps]);

