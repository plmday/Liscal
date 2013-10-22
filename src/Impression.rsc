module Impression


import Prelude;


public data
Imp = Nmr(int nat)
    | Bln(bool bln)
    | Smb(str nom)
    | Lst(list[Imp] imps)
    | Cls(Imp pat, Imp bod, int dep)
    | Prm(str nom, Rsl(list[Imp] args, Env env))
    | Rpl(str msg);

public alias
Scp = map[Imp, Imp];

public alias
Env = list[Scp];

public alias
Rsl = tuple[Imp wnf, Env env];


public Imp
Fal = Bln(false);

public Imp
Tru = Bln(true);

public Imp
Nil = Rpl("");

public Env
empty = [()];


public data
Order = LT() | EQ() | GT();


public Order
compare(Imp imp1, Imp imp2) {
  switch (<imp1, imp2>) {
    case <Nmr(nat1), Nmr(nat2)>: {
      if (nat1 < nat2) return LT();
      if (nat1 > nat2) return GT();
      return EQ();
    }
    case <Bln(bln1), Bln(bln2)>: {
      if (bln1 < bln2) return LT();
      if (bln1 > bln2) return GT();
      return EQ();
    }
    case <Smb(nom1), Smb(nom2)>: {
      if (nom1 < nom2) return LT();
      if (nom1 > nom2) return GT();
      return EQ();
    }
    case <Lst(imps1), Lst(imps2)>: {
      return compareLists(imps1, imps2);
    }
  }
}


private Order
compareLists(list[Imp] imps1, list[Imp] imps2) {
  len1 = size(imps1);
  len2 = size(imps2);

  if (len1 < len2) return LT();
  if (len1 > len2) return GT();
  for (<imp1, imp2> <- zip(imps1, imps2)) {
    switch (compare(imp1, imp2)) {
      case LT(): return LT();
      case EQ(): continue;
      case GT(): return GT();
    }
  }
  return EQ();
}


public bool
lt(Imp imp1, Imp imp2) = compare(imp1, imp2) == LT();

public bool
eq(Imp imp1, Imp imp2) = compare(imp1, imp2) == EQ();

public bool
gt(Imp imp1, Imp imp2) = compare(imp1, imp2) == GT();

