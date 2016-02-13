/*****************************************************************************/
//
//
//
/*****************************************************************************/
module test(
  input	iCLK,
  input	iRESET_
);

  bit	rst_btn;
  unchatter s1( .iCLK(iCLK), .iDATA(iRESET_), .oDATA(rst_btn)  );
  

  logic	[31:0]	iDATA;

  logic	[20:0]	read_counter;
  logic	[31:0]	r_data, w_data;
  bit		w_sig, r_sig;
  bit		r_wait, w_wait;
  perceptron_qsys u0(
    .clk_clk                       (iCLK),		//               clk.clk
    .reset_reset_n                 (rst_btn),	//             reset.reset_n
    .fifo_cpu2fpga_out_readdata    (r_data),		// fifo_cpu2fpga_out.readdata
    .fifo_cpu2fpga_out_read        (r_sig),		//                  .read
    .fifo_cpu2fpga_out_waitrequest (r_wait),		//                  .waitrequest
    .fifo_fpga2cpu_in_writedata    (w_data),		//  fifo_fpga2cpu_in.writedata
    .fifo_fpga2cpu_in_write        (w_sig),		//                  .write
    .fifo_fpga2cpu_in_waitrequest  (w_wait)		//                  .waitrequest
  );

/****************************************************************************/
//  read data
  always_ff @(posedge iCLK) begin
    if(read_counter == 21'd1000000) begin
      read_counter	<= 21'd0;
      r_sig				<= 1'b1;
    end
    else begin
      read_counter	<= read_counter + 21'd1;
      r_sig				<= 1'b0;
    end
  end 
  
  always_ff @(negedge iCLK) begin
    if(r_sig) begin
      if(r_data == 32'hffffffff) begin
        iDATA		<= 32'h10000001;
      end
      else if(r_data == 32'h00000000) begin
        iDATA		<= r_data;
      end
      else begin
        iDATA		<= r_data;
      end
    end
    else begin
      iDATA			<= iDATA;
    end
  end 
  
/*****************************************************************************/
//  write data
  always_ff @(posedge iCLK) begin
    if(r_sig) begin
      w_sig		<= 1'b1;
      w_data	<= w_value;
    end
    else begin
      w_sig		<= 1'b0;
    end
  end


/*****************************************************************************/
//  main
  logic	[31:0]	v0, v1, v2, v12;
  initial v0		= 32'hbf4ccccc;	//  -0.5
  initial v1		= 32'h3f4ccccc;	//   0.8
  initial v2		= 32'h3f4ccccc;	//   0.8
  initial v12		= 32'hbf4ccccc;	//  -0.8
  logic	[31:0]	mid_x0, mid_x1, mid_x2, mid_x12;
  in_layer in_layer0(
    .iCLK(iCLK),
    .iDATA(iDATA),

    .oX0(mid_x0),
    .oX1(mid_x1),
    .oX2(mid_x2),
    .oX12(mid_x12)
  );

  logic	[31:0]	temp_z;  
  mid_layer mid_layer1(
    .iCLK(iCLK),
    .iX0(mid_x0),
    .iX1(mid_x1),
    .iX2(mid_x2),
    .iX12(mid_x12),
    .iWEIGHT_V0(v0),
    .iWEIGHT_V1(v1),
    .iWEIGHT_V2(v2),
    .iWEIGHT_V12(v12),
  
    .oSUM(temp_z)
  );

  logic	[31:0]	new_v0, new_v1, new_v2, new_v12;
  logic	[31:0]	teacher;
  assign teacher	= {31'd0, iDATA[28]};
  logic	[31:0]	w_value;
  out_layer out_layer2(
    .iCLK(iCLK),
    .iSUM(temp_z),
    .iMID_VALUE0(mid_x0),
    .iMID_VALUE1(mid_x1),
    .iMID_VALUE2(mid_x2),
    .iMID_VALUE12(mid_x12),
    .iTEACH(teacher),
    .iWEIGHT_V0(v0),
    .iWEIGHT_V1(v1),
    .iWEIGHT_V2(v2),
    .iWEIGHT_V12(v12),
  
    .oWEIGHT_V0(new_v0),
    .oWEIGHT_V1(new_v1),
    .oWEIGHT_V2(new_v2),
    .oWEIGHT_V12(new_v12),
    .oOUTPUT(w_value)
  );
  
/*****************************************************************************/
//  update weight 
  always_ff @(posedge iCLK) begin
    if(r_sig) begin
        v0		<= new_v0;
        v1		<= new_v1;
        v2		<= new_v2;
        v12		<= new_v12;
    end
  end

endmodule
