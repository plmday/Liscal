module Initialization


import Prelude;
import Impression;


public Env
initial = [(
  Smb("+")
    : Prm("+",
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 + nat2), env>;
          }),
  Smb("-")
    : Prm("-",
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 > nat2 ? nat1 - nat2 : 0), env>;
          }),
  Smb("*")
    : Prm("*",
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 * nat2), env>;
          }),
  Smb("/")
    : Prm("/",
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 / nat2), env>;
          }),
  Smb("%")
    : Prm("%",
          Rsl([Nmr(nat1), Nmr(nat2)], Env env) {
            return <Nmr(nat1 % nat2), env>;
          }),
  Smb("\<")
    : Prm("\<",
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(lt(imp1, imp2)), env>;
          }),
  Smb("=")
    : Prm("=",
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(eq(imp1, imp2)), env>;
          }),
  Smb("\>")
    : Prm("\>",
          Rsl([Imp imp1, Imp imp2], Env env) {
            return <Bln(gt(imp1, imp2)), env>;
          }),
  Smb("~")
    : Prm("~",
          Rsl([Bln(bln)], Env env) {
            return <Bln(! bln1), env>;
          }),
  Smb("&")
    : Prm("&",
          Rsl([Bln(bln1), Bln(bln2)], Env env) {
            return <Bln(bln1 && bln2), env>;
          }),
  Smb("|")
    : Prm("|",
          Rsl([Bln(bln1), Bln(bln2)], Env env) {
            return <Bln(bln1 || bln2), env>;
          }),
  Smb("null?")
    : Prm("null?",
          Rsl([Lst([*Imp imps])], Env env) {
            return <Bln(isEmpty(imps)), env>;           
          }),
  Smb("join")
    : Prm("join",
          Rsl([Imp imp, Lst([*Imp imps])], Env env) {
            return <Lst([imp, *imps]), env>;
          }),
  Smb("head")
    : Prm("head",
          Rsl([Lst([*Imp imps])], Env env) {
            return <head(imps), env>;
          }),
  Smb("tail")
    : Prm("tail",
          Rsl([Lst([*Imp imps])], Env env) {
            return <Lst(tail(imps)), env>;
          }),
  Smb("list")
    : Prm("list",
          Rsl([*Imp imps], Env env) {
            return <Lst(imps), env>;
          })
)];

