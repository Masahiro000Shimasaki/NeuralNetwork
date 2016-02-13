module func_sigmoid(
  input				iCLK,
  input	[31:0]	iSUM,
    
  output	[31:0]	oSIGMOID
);

  logic	[31:0]	alpha, fp_1;
  assign	alpha	= 32'hbf800000;	//  -1.0
  assign	fp_1	= 32'h3f800000;	//  1.0

//  (-1) * WX
  logic	[31:0]	inv_wx;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(alpha),
    .datab(iSUM),
    .result(inv_wx)
  );
//  exp(-WX)
  logic	[31:0]	exp_wx;
  fp_exp exp1(
    .clock(iCLK),
    .data(inv_wx),
    .result(exp_wx)
  );
//  1 + exp(-WX)
  logic	[31:0]	denom_sigm;
  fp_add_sub inst2(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(fp_1),
    .datab(exp_wx),
    .result(denom_sigm)
  );
//  1 / ( 1+exp(-WX))
  fp_divide div1(
    .clock(iCLK),
    .dataa(fp_1),
    .datab(denom_sigm),
    .result(oSIGMOID)
  );
  
endmodule
