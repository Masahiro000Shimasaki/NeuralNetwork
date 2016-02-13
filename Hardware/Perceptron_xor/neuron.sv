/*****************************************************************************/
//
/*****************************************************************************/
module neuron(
  input				iCLK,
  input	[31:0]	iDATA,
  input	[31:0]	iWEIGHT,
  
  output	[31:0]	oDATA
);


  logic	[31:0]	fp_data;
  fp_convert conv1(
    .clock(iCLK),
    .dataa(iDATA),
    .result(fp_data)
  );
  
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(fp_data),
    .datab(iWEIGHT),
    .result(oDATA)
  );


endmodule
