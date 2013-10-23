module Interaction


import Prelude;
import Expression;
import Internalization;
import Impression;
import Normalization;
import Externalization;
import Initialization;
import util::IDE;


public Rsl
normalize(str inp, Env env) = normalize(internalize(inp), env);


public void
lascarINEL() {
  env = initial;

  createConsole(
    "Lascar Console",
    "Welcome to the Lascar Processor\nLascar\> ",
    str (str inp) {
      <wnf, env> = normalize(inp, env);
      return "<externalize(wnf)>\nLascar\> ";
    }
  );
}

