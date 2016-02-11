module calculate_in(
  input				iCLK,
  input	[31:0]	iSUM0,
  input	[31:0]	iSUM1,
  
  output	[31:0]	oSUM
);


  fp_add_sub inst1(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iSUM0),
    .datab(iSUM1),
    .result(oSUM)
  );

endmodule
