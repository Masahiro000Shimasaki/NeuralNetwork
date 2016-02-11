module calculate_mid(
  input				iCLK,
  input	[31:0]	iSUM0,
  input	[31:0]	iSUM1,
  input	[31:0]	iSUM2,
  input	[31:0]	iSUM12,
  
  output	[31:0]	oSUM
);

 
  logic	[31:0]	temp1;
  fp_add_sub inst1(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iSUM0),
    .datab(iSUM1),
    .result(temp1)
  );
  logic	[31:0]	temp2;
  fp_add_sub inst2(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iSUM2),
    .datab(iSUM12),
    .result(temp2)
  );
  
  fp_add_sub inst3(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(temp1),
    .datab(temp2),
    .result(oSUM)
  );

endmodule
