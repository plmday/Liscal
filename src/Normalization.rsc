module Normalization


import Prelude;
import Impression;
import Externalization;


public Env
reside(list[Imp] vars, list[Imp] wnfs, Env env)
  = [(vars[ind] : wnfs[ind] | ind <- index(vars))] + env;


public int
search(Imp var, Env env) {
  for (ind <- index(env)) {
    if (var in env[ind])
      return ind;
  }
  return -1;
}


public Imp
normalize(Imp imp) = normalize(imp, empty);

public Rsl
normalize(var:Smb(nom), Env env) {
  ind = search(var, env);
  if (ind < 0)
    return <Rpl("Unbound variable: <nom>"), env>;
  else
    return <env[ind][var], env>;
}

public Rsl
normalize(Lst([Smb("if"), Imp cnd, Imp csq, Imp alt]), Env env) {
  <wnf, env> = normalize(cnd, env);
  switch (wnf) {
    case Bln(true): return normalize(csq, env);
    case Bln(false): return normalize(alt, env);
    default: return <Rpl("Designating non-truth-value: <cnd>"), env>;
  }
}

public Rsl
normalize(Lst([Smb("begin"), *Imp imps]), Env env) {
  wnf = Nil;
  for (Imp imp <- imps)
    <wnf, env> = normalize(imp, env);
  return <wnf, env>;
}

public Rsl
normalize(Lst([Smb("set!"), Imp var, Imp imp]), Env env) {
  <wnf, env> = normalize(imp, env);
  ind = search(var, env);
  if (ind < 0)
    return <Rpl("Unbound variable: <nom>"), env>;
  else {
    env[ind][var] = wnf;
    return <Nil, env>;
  }
}

public Rsl
normalize(Lst([Smb("define"), Imp pat, Imp imp]), Env env) {
  switch (pat) {
    case Lst([var:Smb(nom), *pars]): {
      dep = size(env);
      env[0][var]
        = Prc(nom, size(pars),
              Rsl([*Imp args], Env env) {
                return normalize(imp, reside(pars, args, tail(env, dep)));
              });
      return <Nil, env>;
    }
    case Smb(nom): {
      <wnf, env> = normalize(imp, env);
      env[0][pat] = wnf;
      return <Nil, env>;
    }
    default: return <Rpl("Illegal pattern: <externalize(pat)>"), env>;
  }
}

public Rsl
normalize(Lst([*Imp imps]), Env env) {
  if (isEmpty(imps))
    return <Nil, env>;
  return reduce(head(imps), tail(imps), env);
}

public default Rsl
normalize(Imp imp, Env env) = <imp, env>;


public Rsl
reduce(Imp opr, [*Imp opds], Env env) {
  switch (normalize(opr, env).wnf) {
    case Prc(_, _, prc): {
      args = [normalize(opd, env).wnf | opd <- opds];
      return prc(args, env);
    }
    default: return <Rpl("Designating non-procedure: <externalize(opr)>"), env>;
  }
}

