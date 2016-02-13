module new_weight_mid(
  input				iCLK,
  input	[31:0]	iTEACH,
  input	[31:0]	iOUTPUT,
  input	[31:0]	iMID_VALUE1,
  input	[31:0]	iMID_VALUE2,
  input	[31:0]	iMID_VALUE12,
  input	[31:0]	iWEIGHT_V0,
  input	[31:0]	iWEIGHT_V1,
  input	[31:0]	iWEIGHT_V2,
  
  output	[31:0]	oWEIGHT_V0,
  output	[31:0]	oWEIGHT_V1,
  output	[31:0]	oWEIGHT_V2,
  output	[31:0]	oERROR
);

/*****************************************************************************/
//  calculate error
  logic	[31:0]	error_o;
  calculate_error er1(
    .iCLK(iCLK),
    .iTEACH(iTEACH),
    .iOUTPUT(iOUTPUT),
  
    .oERROR(error_o)
  );

/*****************************************************************************/
//  
  logic	[31:0]	delta_v0, delta_v1, delta_v2;
  calculate_delta_mid delta0(
    .iCLK(iCLK), .iERROR(error_o), .iMID_VALUE(iMID_VALUE1),  .oDELTA(delta_v0)
  );
  calculate_delta_mid delta1(
    .iCLK(iCLK), .iERROR(error_o), .iMID_VALUE(iMID_VALUE2),  .oDELTA(delta_v1)
  );
  calculate_delta_mid delta2(
    .iCLK(iCLK), .iERROR(error_o), .iMID_VALUE(iMID_VALUE12), .oDELTA(delta_v2)
  );
  
/*****************************************************************************/
//  new weight_v
  fp_add_sub add0(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT_V0),
    .datab(delta_v0),
    .result(oWEIGHT_V0)
  );
  fp_add_sub add1(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT_V1),
    .datab(delta_v1),
    .result(oWEIGHT_V1)
  );
  fp_add_sub add2(
    .add_sub(1'b1),
    .clock(iCLK),
    .dataa(iWEIGHT_V2),
    .datab(delta_v2),
    .result(oWEIGHT_V2)
  );

  assign oERROR	= error_o;

endmodule
