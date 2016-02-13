/*****************************************************************************/
//
//
/*****************************************************************************/
module out_layer(
  input				iCLK,
  input	[31:0]	iSUM,
  input	[31:0]	iMID_VALUE0,
  input	[31:0]	iMID_VALUE1,
  input	[31:0]	iMID_VALUE2,
  input	[31:0]	iMID_VALUE12,
  input	[31:0]	iTEACH,
  input	[31:0]	iWEIGHT_V0,
  input	[31:0]	iWEIGHT_V1,
  input	[31:0]	iWEIGHT_V2,
  input	[31:0]	iWEIGHT_V12,
  
  output	[31:0]	oWEIGHT_V0,
  output	[31:0]	oWEIGHT_V1,
  output	[31:0]	oWEIGHT_V2,
  output	[31:0]	oWEIGHT_V12,
  output	[31:0]	oOUTPUT
);

/*****************************************************************************/
//  convert teach
  logic	[31:0]	fp_teach;
  fp_convert conv2(
    .clock(iCLK),
    .dataa(iTEACH),
    .result(fp_teach)
  );

/*****************************************************************************/
//  calculate Z
  logic	[31:0]	z;
  func_sigmoid sigm1(
    .iCLK(iCLK),
    .iSUM(iSUM),
	 
    .oSIGMOID(z)
  );
 
/*****************************************************************************/
//  calculate weight
  calculate_weight(
    .iCLK(iCLK),
    .iTEACH(fp_teach),
    .iOUTPUT(z),
    .iMID_VALUE0(iMID_VALUE0),
    .iMID_VALUE1(iMID_VALUE1),
    .iMID_VALUE2(iMID_VALUE2),
    .iMID_VALUE12(iMID_VALUE12),
    .iWEIGHT_V0(iWEIGHT_V0),
    .iWEIGHT_V1(iWEIGHT_V1),
    .iWEIGHT_V2(iWEIGHT_V2),
    .iWEIGHT_V12(iWEIGHT_V12),
  
    .oWEIGHT_V0(oWEIGHT_V0),
    .oWEIGHT_V1(oWEIGHT_V1),
    .oWEIGHT_V2(oWEIGHT_V2),
    .oWEIGHT_V12(oWEIGHT_V12)
  );

  assign oOUTPUT	= z;
  

endmodule
