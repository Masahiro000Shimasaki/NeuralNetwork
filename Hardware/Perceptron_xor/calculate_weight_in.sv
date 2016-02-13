module calculate_weight_in(
  input				iCLK,
  input	[31:0]	iWEIGHT1_0,
  input	[31:0]	iWEIGHT1_1,
  input	[31:0]	iWEIGHT2_0,
  input	[31:0]	iWEIGHT2_2,
  input	[31:0]	iWEIGHT12_0,
  input	[31:0]	iWEIGHT12_1,
  input	[31:0]	iWEIGHT12_2,
  input	[31:0]	iWEIGHT_V0,
  input	[31:0]	iWEIGHT_V1,
  input	[31:0]	iWEIGHT_V2,
  input	[31:0]	iX1,
  input	[31:0]	iX2,
  input	[31:0]	iMID_VALUE1,
  input	[31:0]	iMID_VALUE2,
  input	[31:0]	iMID_VALUE12,
  input	[31:0]	iERROR,

  output	[31:0]	oWEIGHT1_0,
  output	[31:0]	oWEIGHT1_1,
  output	[31:0]	oWEIGHT2_0,
  output	[31:0]	oWEIGHT2_2,
  output	[31:0]	oWEIGHT12_0,
  output	[31:0]	oWEIGHT12_1,
  output	[31:0]	oWEIGHT12_2
);


/*****************************************************************************/
//  calculate error
  logic	[31:0]	error_x1, error_x2, error_x12;
  calculate_in_error er1(
    .iCLK(iCLK),
    .iMID_VALUE(iMID_VALUE1),
    .iWEIGHT_V(iWEIGHT_V0),
    .iERROR(iERROR),
  
    .oERROR(error_x1)
  );
  calculate_in_error er2(
    .iCLK(iCLK),
    .iMID_VALUE(iMID_VALUE2),
    .iWEIGHT_V(iWEIGHT_V1),
    .iERROR(iERROR),
  
    .oERROR(error_x2)
  );
  calculate_in_error er12(
    .iCLK(iCLK),
    .iMID_VALUE(iMID_VALUE12),
    .iWEIGHT_V(iWEIGHT_V2),
    .iERROR(iERROR),
  
    .oERROR(error_x12)
  );

/*****************************************************************************/
//  calculate delta
  logic	[31:0]	delta1_0, delta1_1;
  logic	[31:0]	delta2_0, delta2_2;
  logic	[31:0]	delta12_0, delta12_1, delta12_2;
  logic	[31:0]	x0;
  assign x0	= 32'h3f800000;	//  1.0
  calculate_delta_in delta0(
    .iCLK(iCLK), .iERROR(error_x1), .iX(x0),   .oDELTA(delta1_0)
  );
  calculate_delta_in delta1(
    .iCLK(iCLK), .iERROR(error_x1), .iX(iX1),  .oDELTA(delta1_1)
  );
  calculate_delta_in delta2(
    .iCLK(iCLK), .iERROR(error_x2), .iX(x0),   .oDELTA(delta2_0)
  );
  calculate_delta_in delta3(
    .iCLK(iCLK), .iERROR(error_x2), .iX(iX2),  .oDELTA(delta2_2)
  );
  calculate_delta_in delta4(
    .iCLK(iCLK), .iERROR(error_x12), .iX(x0),  .oDELTA(delta12_0)
  );
  calculate_delta_in delta5(
    .iCLK(iCLK), .iERROR(error_x12), .iX(iX1), .oDELTA(delta12_1)
  );
  calculate_delta_in delta6(
    .iCLK(iCLK), .iERROR(error_x12), .iX(iX2), .oDELTA(delta12_2)
  );

/*****************************************************************************/
//  
  fp_add_sub add0(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT1_0),
    .datab(delta1_0),
    .result(oWEIGHT1_0)
  );
  fp_add_sub add1(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGH1_1),
    .datab(delta1_1),
    .result(oWEIGHT1_1)
  );
  fp_add_sub add2(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT2_0),
    .datab(delta2_0),
    .result(oWEIGHT2_0)
  );
  fp_add_sub add3(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT2_2),
    .datab(delta2_2),
    .result(oWEIGHT2_2)
  );
  fp_add_sub add4(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT12_0),
    .datab(delta12_0),
    .result(oWEIGHT12_0)
  );
  fp_add_sub add5(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT12_1),
    .datab(delta12_1),
    .result(oWEIGHT12_1)
  );
  fp_add_sub add6(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT12_2),
    .datab(delta12_2),
    .result(oWEIGHT12_2)
  );


endmodule
