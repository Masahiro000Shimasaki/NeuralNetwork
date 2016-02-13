module mid_layer(
  input				iCLK,
  input	[31:0]	iX0,
  input	[31:0]	iX1,
  input	[31:0]	iX2,
  input	[31:0]	iX12,
  input	[31:0]	iWEIGHT_V0,
  input	[31:0]	iWEIGHT_V1,
  input	[31:0]	iWEIGHT_V2,
  input	[31:0]	iWEIGHT_V12,
  
  output	[31:0]	oSUM
);

//  unit * weight
  logic	[31:0]	mid_s0;
  fp_multiplier mult0(
    .clock(iCLK),
    .dataa(iX0),
    .datab(iWEIGHT_V0),
    .result(mid_s0)
  );
  logic	[31:0]	mid_s1;
  fp_multiplier mult1(
    .clock(iCLK),
    .dataa(iX1),
    .datab(iWEIGHT_V1),
    .result(mid_s1)
  );
  logic	[31:0]	mid_s2;
  fp_multiplier mult2(
    .clock(iCLK),
    .dataa(iX2),
    .datab(iWEIGHT_V2),
    .result(mid_s2)
  );
  logic	[31:0]	mid_s12;
  fp_multiplier mult12(
    .clock(iCLK),
    .dataa(iX12),
    .datab(iWEIGHT_V12),
    .result(mid_s12)
  );

//  calculate mid_layer S  
  calculate_mid inst1(
    .iCLK(iCLK),
    .iSUM0(mid_s0),
    .iSUM1(mid_s1),
    .iSUM2(mid_s2),
    .iSUM12(mid_s12),
  
    .oSUM(oSUM)
  ); 


endmodule
