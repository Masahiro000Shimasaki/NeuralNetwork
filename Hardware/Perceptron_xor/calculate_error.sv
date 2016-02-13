module calculate_error(
  input				iCLK,
  input	[31:0]	iTEACH,
  input	[31:0]	iOUTPUT,
  
  output	[31:0]	oERROR
);

  //  teach - output
  logic	[31:0]	temp1;
  fp_add_sub sub1(
    .add_sub(1'b0),
    .clock(iCLK),
    .dataa(iTEACH),
    .datab(iOUTPUT),
    .result(temp1)
  );
  
  //  1 - output
  logic	[31:0]	fp_1;
  assign fp_1	= 32'h3f800000;	//  1.0
  logic	[31:0]	temp2;
  fp_add_sub sub3(
    .add_sub(1'b0),
    .clock(iCLK),
    .dataa(fp_1),
    .datab(iOUTPUT),
    .result(temp2)
  );
  
  //  output * (1 - output)
  logic	[31:0]	sigm_dash;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(iOUTPUT),
    .datab(temp2),
    .result(sigm_dash)
  );

  //  (teach - output) * output * (1 - output)
  fp_multiplier mult2(
    .clock(iCLK),
    .dataa(sigm_dash),
    .datab(temp1),
    .result(oERROR)
  );

endmodule
