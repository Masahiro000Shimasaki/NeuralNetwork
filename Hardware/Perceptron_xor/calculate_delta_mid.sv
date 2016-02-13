module calculate_delta_mid(
  input				iCLK,
  input	[31:0]	iERROR,
  input	[31:0]	iMID_VALUE,
  
  output	[31:0]	oDELTA
);
  
  
  //  mu * iMID_VALUE
  logic	[31:0]	mu;
  assign	mu	= 32'h3e800000;	//  0.25
  logic	[31:0]	temp1;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(mu),
    .datab(iMID_VALUE),
    .result(temp1)
  );
  
  //  mu * iMID_VALUE * error_o
  fp_multiplier mult2(
    .clock(iCLK),
    .dataa(iERROR),
    .datab(temp1),
    .result(oDELTA)
  );

endmodule
