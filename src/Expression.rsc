module Expression


layout
Sps = [\t-\r\ ]*;


lexical
Dec = [0-9]+ !>> [0-9];

lexical
Idr = (![0-9()\t-\r\ ])+ !>> ![0-9()\t-\r\ ];


start syntax Exp
  = Dec
  | Idr
  | "(" Exp* ")";

