module Annotation


import Prelude;
import Impression;


anno set[Imp] Imp @ fvs;


public Imp
annotate(var:Smb(_)) {
  return var @ fvs = {var};
}

public Imp
annotate(ife:Lst([Smb("if"), Imp cnd, Imp csq, Imp alt])) {
  cnd1 = annotate(cnd);
  csq1 = annotate(csq);
  alt1 = annotate(alt);
  ife1 = Lst([Smb("if"), cnd1, csq1, alt1]);
  return ife1 @ fvs = cnd1 @ fvs + csq1 @ fvs + alt1 @ fvs;
}

public Imp
annotate(bgn:Lst([Smb("begin"), *Imp imps])) {
  imps1 = [annotate(imp) | imp <- imps];
  bgn1 = Lst([Smb("begin"), *imps1]);
  return bgn1 @ fvs = ({} | it + imp @ fvs | imp <- imps1);
}

public Imp
annotate(ass:Lst([Smb("set!"), var:Smb(_), Imp imp])) {
  imp1 = annotate(imp);
  ass1 = Lst([Smb("set!"), var, imp1]);
  return ass1 @ fvs = imp1 @ fvs - {var};
}

public Imp
annotate(def:Lst([Smb("define"), var:Smb(_), Imp imp])) {
  imp1 = annotate(imp);
  def1 = Lst([Smb("define"), var, imp1]);
  return def1 @ fvs = imp1 @ fvs - {var};
}
 
public Imp
annotate(def:Lst([Smb("define"), cmb:Lst([*Imp vars]), Imp bod])) {
  bod1 = annotate(bod);
  def1 = Lst([Smb("define"), cmb, bod1]);
  return def1 @ fvs = bod1 @ fvs - toSet(vars);
}

public Imp
annotate(app:Lst([*Imp imps])) {
  imps1 = [annotate(imp) | imp <- imps];
  app1 = Lst(imps1);
  return app1 @ fvs = ({} | it + imp @ fvs | imp <- imps1);
}

public default Imp
annotate(Imp imp) {
  return imp @ fvs = {};
}

