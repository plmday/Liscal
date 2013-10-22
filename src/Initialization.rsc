module Initialization


import Prelude;
import Impression;


public int
pInf = 1024;

public Env
initial = [(
  Smb("+")
    : Prc(Smb("+"), 2,
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 + nat2), env>;
          }),
  Smb("-")
    : Prc(Smb("-"), 2,
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 > nat2 ? nat1 - nat2 : 0), env>;
          }),
  Smb("*")
    : Prc(Smb("*"), 2,
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 * nat2), env>;
          }),
  Smb("/")
    : Prc(Smb("/"), 2,
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 / nat2), env>;
          }),
  Smb("%")
    : Prc(Smb("%"), 2,
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 % nat2), env>;
          }),
  Smb("\<")
    : Prc(Smb("\<"), 2,
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(lt(imp1, imp2)), env>;
          }),
  Smb("=")
    : Prc(Smb("="), 2,
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(eq(imp1, imp2)), env>;
          }),
  Smb("\>")
    : Prc(Smb("\>"), 2,
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(gt(imp1, imp2)), env>;
          }),
  Smb("~")
    : Prc(Smb("~"), 1,
          Rsl([Bln(bln)], Env env) {
            return <Bln(! bln1), env>;
          }),
  Smb("&")
    : Prc(Smb("&"), 2,
          Rsl([Bln(bln1), Bln(bln2)], Env env) {
            return <Bln(bln1 && bln2), env>;
          }),
  Smb("|")
    : Prc(Smb("|"), 2,
          Rsl([Bln(bln1), Bln(bln2)], Env env) {
            return <Bln(bln1 || bln2), env>;
          }),
  Smb("null?")
    : Prc(Smb("null?"), 1,
          Rsl([Lst([*Imp imps])], Env env) {
            return <Bln(isEmpty(imps)), env>;           
          }),
  Smb("join")
    : Prc(Smb("join"), 2,
          Rsl([Imp imp, Lst([*Imp imps])], Env env) {
            return <Lst([imp, *imps]), env>;
          }),
  Smb("head")
    : Prc(Smb("head"), 1,
          Rsl([Lst([*Imp imps])], Env env) {
            return <head(imps), env>;
          }),
  Smb("tail")
    : Prc(Smb("tail"), 1,
          Rsl([Lst([*Imp imps])], Env env) {
            return <Lst(tail(imps)), env>;
          }),
  Smb("list")
    : Prc(Smb("list"), pInf,
          Rsl([*Imp imps], Env env) {
            return <Lst(imps), env>;
          })
)];

