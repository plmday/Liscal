module Annotation


import Prelude;
import Impression;


anno set[Imp] Imp @ fvs;


public Imp
annotateFVs(var:Smb(_)) {
  return var @ fvs = {var};
}

public Imp
annotateFVs(ife:Lst([Smb("if"), Imp cnd, Imp csq, Imp alt])) {
  return ife @ fvs = annotateFVs(cnd) @ fvs
             + annotateFVs(csq) @ fvs + annotateFVs(alt) @ fvs;
}

public Imp
annotateFVs(bgn:Lst([Smb("begin"), *Imp imps])) {
  return bgn @ fvs = ({} | it + annotateFVs(imp) @ fvs | imp <- imps);
}

public Imp
annotateFVs(ass:Lst([Smb("set!"), var:Smb(_), Imp imp])) {
  return ass @ fvs = annotateFVs(imp) @ fvs - {var};
}

public Imp
annotateFVs(def:Lst([Smb("define"), var:Smb(_), Imp imp])) {
  return def @ fvs = annotateFVs(imp) @ fvs - {var};
}
 
public Imp
annotateFVs(def:Lst([Smb("define"), Lst([*Imp vars]), Imp bod])) {
  return def @ fvs = annotateFVs(bod) @ fvs - {var | var <- vars};
}

public Imp
annotateFVs(app:Lst([*Imp imps])) {
  return app @ fvs = ({} | it + annotateFVs(imp) @ fvs | imp <- imps);
}

public default Imp
annotateFVs(Imp imp) {
  return imp @ fvs = {};
}

