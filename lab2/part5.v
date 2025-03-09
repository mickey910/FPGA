/*part5 flash digit0~9*/
module part5 (CLOCK_50, HEX0);
input CLOCK_50;
output [6:0] HEX0;

wire [25:0] Q;
reg [3:0] flash_count;
reg reset;

assign clk = CLOCK_50;

//define
part5_counter cclk(clk, reset, Q);

always @(posedge clk)begin//count 1 sec
	if(Q == 26'd49999998)
		reset <= 1;
	else if(Q >= 26'd49999999)begin
		if(flash_count >= 4'b1001)begin
			flash_count <= 0;
			reset <= 0;
		end
		else begin			
			flash_count <= flash_count + 1;
			reset <= 0;
		end
	end 
	else
		reset <= 0;
end

reg [6:0] reg_HEX0;
assign HEX0 = reg_HEX0;
always @(*)begin//HEX0
	case (flash_count)
		4'b0000: reg_HEX0 = 7'b1000000; // 0
		4'b0001: reg_HEX0 = 7'b1111001; // 1
		4'b0010: reg_HEX0 = 7'b0100100; // 2
		4'b0011: reg_HEX0 = 7'b0110000; // 3
		4'b0100: reg_HEX0 = 7'b0011001; // 4
		4'b0101: reg_HEX0 = 7'b0010010; // 5
		4'b0110: reg_HEX0 = 7'b0000010; // 6
		4'b0111: reg_HEX0 = 7'b1111000; // 7
		4'b1000: reg_HEX0 = 7'b0000000; // 8
		4'b1001: reg_HEX0 = 7'b0010000; // 9
		default: reg_HEX0 = 7'b1000000; // 0
	 endcase
end
endmodule