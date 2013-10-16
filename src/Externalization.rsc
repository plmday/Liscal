module Externalization


import Impression;


public str
externalize(Nmr(nat)) = "<nat>";

public str
externalize(Bln(bln)) = bln ? "true" : "false";

public str
externalize(Smb(nom)) = nom;

public str
externalize(Lst([*Imp imps])) = "(" + printList(imps) + ")";

public str
externalize(Cls(Imp pat, Imp bod, Env _)) = "_<externalize(pat)>";

public str
externalize(Prm(nom, _)) = "<nom>(...)";

public str
externalize(Rpl(msg)) = msg;


private str
printList([Imp imp]) = externalize(imp);

private str
printList([Imp imp, *Imp imps]) = externalize(imp) + " " + printList(imps);

