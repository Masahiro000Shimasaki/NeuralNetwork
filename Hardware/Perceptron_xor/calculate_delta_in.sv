module calculate_delta_in(
  input         iCLK,
  input	[31:0]  iERROR,
  input	[31:0]  iX,
  
  output	[31:0]	oDELTA
);
  
  //  error_h * X
  logic	[31:0]	temp1;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(iERROR),
    .datab(iX),
    .result(temp1)
  );
  
  //  mu * (error_o * iMID_VALUE)
  logic	[31:0]	mu;
  assign	mu	= 32'h3f400000;	// 0.75
  fp_multiplier mult2(
    .clock(iCLK),
    .dataa(mu),
    .datab(temp1),
    .result(oDELTA)
  );

endmodule

