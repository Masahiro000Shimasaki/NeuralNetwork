/*****************************************************************************/
//
/*****************************************************************************/
module in_layer(
  input				iCLK,
  input	[31:0]	iDATA,

  output	[31:0]	oX0,
  output	[31:0]	oX1,
  output	[31:0]	oX2,
  output	[31:0]	oX12
);


  logic	[31:0]	x0, x1, x2, x12;
  logic	[31:0]	t_x1, t_x2;
  assign t_x1	= {31'd0, iDATA[0]};
  assign t_x2	= {31'd0, iDATA[1]};
  assign x0		= ((t_x1 == 32'd0) && (t_x2 == 32'd0)) ? 32'h00000001 : 32'h00000000;
  assign x1		= ((t_x1 == 32'd0) && (t_x2 == 32'd1)) ? 32'h00000001 : 32'h00000000;
  assign x2		= ((t_x1 == 32'd1) && (t_x2 == 32'd0)) ? 32'h00000001 : 32'h00000000;
  assign x12	= ((t_x1 == 32'd1) && (t_x2 == 32'd1)) ? 32'h00000001 : 32'h00000000;
 
 
  logic	[31:0]	w0, w1, w2, w12;
  assign w0		= 32'h3f800000;
  assign w1		= 32'h3f800000;
  assign w2		= 32'h3f800000;
  assign w12	= 32'h3f800000;

  neuron n0 ( .iCLK(iCLK), .iDATA(x0),  .iWEIGHT(w0),  .oDATA(oX0)  );
  neuron n1 ( .iCLK(iCLK), .iDATA(x1),  .iWEIGHT(w1),  .oDATA(oX1)  );
  neuron n2 ( .iCLK(iCLK), .iDATA(x2),  .iWEIGHT(w2),  .oDATA(oX2)  );
  neuron n12( .iCLK(iCLK), .iDATA(x12), .iWEIGHT(w12), .oDATA(oX12) );


endmodule
