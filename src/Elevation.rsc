module Elevation


import Prelude;
import Impression;
import Annotation;
import Abstraction;


public alias
Prg = list[Imp];


public Prg
elevate(Prg imps) {
  imps1 = [abstract(annotate(imp)) | imp <- imps];
  defs = ([] | it + imp @ efs | imp <- imps1);
  return defs + imps1;
}

