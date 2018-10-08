// Verilog testbench created by dumbTestbench.py
`timescale 100ns / 1ns

module agc;

`include "2005273A/tb.v"

reg A15_ = 0, A16_ = 0, BMAGXM = 0, BMAGXP = 0, BMAGYM = 0, BMAGYP = 0,
  BMAGZP = 0, CA6_ = 0, CDUXM = 0, CDUXP = 0, CDUYM = 0, CDUYP = 0, CDUZM = 0,
  CDUZP = 0, CGA24 = 0, CI_ = 0, CT = 0, CT_ = 0, DKCTR4 = 0, DKCTR4_ = 0,
  DKCTR5 = 0, DKCTR5_ = 0, F01A = 0, F01B = 0, F02B = 0, F03B_ = 0, F04B = 0,
  F05A = 0, F05B = 0, F06B_ = 0, F07A_ = 0, F07B = 0, F08B_ = 0, F09A = 0,
  F17A = 0, F17B = 0, F18AX = 0, F5ASB0 = 0, F5ASB2 = 0, FF1109_ = 0, FF1110_ = 0,
  FF1111_ = 0, FF1112_ = 0, FS02 = 0, FS03 = 0, FS04 = 0, FS05 = 0, FS06 = 0,
  FS06_ = 0, FS07A = 0, FS07_ = 0, FS08 = 0, FS08_ = 0, FS09 = 0, FS16 = 0,
  FS17 = 0, GOJAM_ = 0, IC11 = 0, MP3 = 0, NISQ_ = 0, OCTAD2 = 0, OCTAD3 = 0,
  ODDSET_ = 0, PIPGZm = 0, PIPGZp = 0, PIPXM = 0, PIPXP = 0, PIPYM = 0,
  PIPYP = 0, RCH_ = 0, RSCT = 0, RT_ = 0, RUSG_ = 0, SB0 = 0, SB1 = 0,
  SB2 = 0, SB4 = 0, SHAFTM = 0, SHAFTP = 0, SUMA15_ = 0, SUMB15_ = 0, T01DC_ = 0,
  T02 = 0, T06 = 0, T08 = 0, T09DC_ = 0, T1P = 0, T2P = 0, T3P = 0, T4P = 0,
  T5P = 0, T6P = 0, TRNM = 0, TRNP = 0, U2BBK = 0, WCH_ = 0, WL01 = 0,
  WL02 = 0, WL03 = 0, WL04 = 0, WL05 = 0, WL06 = 0, WL07 = 0, WL08 = 0,
  WL09 = 0, WL10 = 0, WL11 = 0, WL12 = 0, WL13 = 0, WL14 = 0, WL16 = 0,
  WT_ = 0, XB3_ = 0, XB4_ = 0, XB7_ = 0, XT0_ = 0;

wire BOTHZ, CA2_, CA3_, CCHG_, CDUCLK, CDUSTB_, CHWL01_, CHWL02_, CHWL03_,
  CHWL04_, CHWL05_, CHWL06_, CHWL07_, CHWL08_, CHWL09_, CHWL10_, CHWL11_,
  CHWL12_, CHWL13_, CHWL14_, CHWL16_, CI, CNTRSB_, CTPLS_, ELSNCM, ELSNCN,
  F04B_, F05A_, F05B_, F05D, F07B_, F07C_, F07D_, F09A_, F09D, F5ASB0_,
  F5ASB2_, F7CSB1_, FLASH, FLASH_, FS05_, FS09_, GOJAM, GTONE, GTRST, GTSET,
  GTSET_, HIGH0_, HIGH1_, HIGH2_, HIGH3_, IC11_, LRRST, MISSZ, MNISQ, MON800,
  MRCH, MWATCH_, MWCH, NISQ, NOZM, NOZP, ONE, OT1110, OT1111, OT1112, OUTCOM,
  OVNHRP, PHS3_, PIPASW, PIPDAT, PIPINT, PIPPLS_, PIPZM, PIPZP, RCHAT_,
  RCHBT_, RCHG_, RRRST, RSCT_, SB0_, SB1_, SB2_, T01, T02_, T09, U2BBKG_,
  US2SG, WATCH, WATCHP, WATCH_, WCHG_, d12KPPS, d25KPPS, d3200A, d3200B,
  d3200C, d3200D, d800RST, d800SET;

A24 iA24 (
  rst, A15_, A16_, BMAGXM, BMAGXP, BMAGYM, BMAGYP, BMAGZP, CA6_, CDUXM, CDUXP,
  CDUYM, CDUYP, CDUZM, CDUZP, CGA24, CI_, CT, CT_, DKCTR4, DKCTR4_, DKCTR5,
  DKCTR5_, F01A, F01B, F02B, F03B_, F04B, F05A, F05B, F06B_, F07A_, F07B,
  F08B_, F09A, F17A, F17B, F18AX, F5ASB0, F5ASB2, FF1109_, FF1110_, FF1111_,
  FF1112_, FS02, FS03, FS04, FS05, FS06, FS06_, FS07A, FS07_, FS08, FS08_,
  FS09, FS16, FS17, GOJAM_, IC11, MP3, NISQ_, OCTAD2, OCTAD3, ODDSET_, PIPGZm,
  PIPGZp, PIPXM, PIPXP, PIPYM, PIPYP, RCH_, RSCT, RT_, RUSG_, SB0, SB1, SB2,
  SB4, SHAFTM, SHAFTP, SUMA15_, SUMB15_, T01DC_, T02, T06, T08, T09DC_, T1P,
  T2P, T3P, T4P, T5P, T6P, TRNM, TRNP, U2BBK, WCH_, WL01, WL02, WL03, WL04,
  WL05, WL06, WL07, WL08, WL09, WL10, WL11, WL12, WL13, WL14, WL16, WT_,
  XB3_, XB4_, XB7_, XT0_, CA2_, CA3_, CTPLS_, F05A_, F05B_, F07B_, F5ASB0_,
  F5ASB2_, FS05_, GOJAM, MNISQ, MON800, MRCH, MWATCH_, MWCH, OUTCOM, PIPZM,
  PIPZP, SB0_, SB1_, SB2_, T01, T02_, T09, BOTHZ, CCHG_, CDUCLK, CDUSTB_,
  CHWL01_, CHWL02_, CHWL03_, CHWL04_, CHWL05_, CHWL06_, CHWL07_, CHWL08_,
  CHWL09_, CHWL10_, CHWL11_, CHWL12_, CHWL13_, CHWL14_, CHWL16_, CI, CNTRSB_,
  ELSNCM, ELSNCN, F04B_, F05D, F07C_, F07D_, F09A_, F09D, F7CSB1_, FLASH,
  FLASH_, FS09_, GTONE, GTRST, GTSET, GTSET_, HIGH0_, HIGH1_, HIGH2_, HIGH3_,
  IC11_, LRRST, MISSZ, NISQ, NOZM, NOZP, ONE, OT1110, OT1111, OT1112, OVNHRP,
  PHS3_, PIPASW, PIPDAT, PIPINT, PIPPLS_, RCHAT_, RCHBT_, RCHG_, RRRST, RSCT_,
  U2BBKG_, US2SG, WATCH, WATCHP, WATCH_, WCHG_, d12KPPS, d25KPPS, d3200A,
  d3200B, d3200C, d3200D, d800RST, d800SET
);

endmodule
