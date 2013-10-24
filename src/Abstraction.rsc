module Abstraction


import Prelude;
import Impression;
import Annotation;


anno list[Imp] Imp @ efs;

public Imp
abstract(Lst([Smb("if"), Imp cnd, Imp csq, Imp alt])) {
  cnd1 = abstract(cnd);
  csq1 = abstract(csq);
  alt1 = abstract(alt);
  ife = Lst([Smb("if"), cnd1, csq1, alt1]);
  return ife @ efs = cnd1 @ efs + csq1 @ efs + alt1 @ efs;
}

public Imp
abstract(Lst([Smb("begin"), *Imp imps])) {
  imps1 = [abstract(imp) | imp <- imps];
  bgn = Lst([Smb("begin"), *imps1]);
  return bgn @ efs = ([] | it + imp @ efs | imp <- imps1);
}

public Imp
abstract(Lst([Smb("set!"), Imp var, Imp imp])) {
  imp1 = abstract(imp);
  ass = Lst([Smb("set!"), var, imp1]);
  return ass @ efs = imp1 @ efs;
}

public Imp
abstract(def:Lst([Smb("define"), var:Smb(_), Imp imp])) {
  imp1 = abstract(imp);
  def = Lst([Smb("define"), var, imp1]);
  return def @ efs = imp1 @ efs;
}

public Imp
abstract(def:Lst([Smb("define"), Lst([var:Smb(nom), *Imp pars]), Imp bod])) {
  fvs = toList(def @ fvs);
  bod1 = abstract(bod);
  var1 = Smb("elevated-" + nom);
  pars1 = fvs + pars;
  def1 = Lst([Smb("define"), Lst([var1, *pars1]), bod1]);
  def2 = Lst([Smb("define"), var, Lst([var1, *fvs])]);
  return def2 @ efs = [def1, *(bod1 @ efs)];
}

public Imp
abstract(Lst([*Imp imps])) {
  imps1 = [abstract(imp) | imp <- imps];
  app = Lst(imps1);
  return app @ efs = ([] | it + imp @ efs | imp <- imps1);
}

public default Imp
abstract(Imp imp) {
  imp1 = delAnnotations(imp);
  return imp1 @ efs = [];
}



