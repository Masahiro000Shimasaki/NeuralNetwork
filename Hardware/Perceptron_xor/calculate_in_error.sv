module calculate_in_error(
  input				iCLK,
  input	[31:0]	iMID_VALUE,
  input	[31:0]	iWEIGHT_V,
  input	[31:0]	iERROR,
  
  output	[31:0]	oERROR
);

  //  1 - iMID_VALUE
  logic	[31:0]	temp1;
  logic	[31:0]	fp_1;
  assign fp_1	= 32'h3f800000;	//  1.0
  fp_add_sub add1(
    .add_sub(1'b0),
    .clock(iCLK),
    .dataa(fp_1),
    .datab(iMID_VALUE),
    .result(temp1)
  );
  
  //  iMID_VALUE * (1 - iMID_VALUE)
  logic	[31:0]	sigm_dash;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(iMID_VALUE),
    .datab(temp1),
    .result(sigm_dash)
  );

  //  error_o * weight_v
  logic	[31:0]	temp2;
  fp_multiplier mult2(
    .clock(iCLK),
    .dataa(iERROR),
    .datab(iWEIGHT_V),
    .result(temp2)
  );
  
  //  iMID_VALUE * (1 - iMID_VALUE) * sigma(error * weight_v)
  fp_multiplier mult4(
    .clock(iCLK),
    .dataa(sigm_dash),
    .datab(temp2),
    .result(oERROR)
  );

endmodule
