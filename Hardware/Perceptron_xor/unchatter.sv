module unchatter(
  input	iCLK,
  input	iDATA,
  output	oDATA
);

  reg	[15:0]	cnt;
  reg				dff;

  always @(posedge iCLK) begin
    cnt <= cnt + 1;
  end
	
  always @(posedge cnt[15]) begin
    dff <= iDATA;
  end
	
  assign oDATA = dff;
	
endmodule
