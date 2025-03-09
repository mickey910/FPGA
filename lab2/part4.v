/*part4  16bit LPM COUNTER with noblocking*/
module part4(KEY, SW, HEX3,HEX2, HEX1, HEX0);
input [3:0] KEY;
input [9:0] SW;
output [6:0] HEX3,HEX2, HEX1, HEX0;
wire clk, enable, reset;
wire [15:0] Q ;

assign clk = KEY[0];
assign reset = SW[0];
assign enable = SW[1];


reg [6:0] a, b, c, d;
assign HEX0 = a;
assign HEX1 = b;
assign HEX2 = c;
assign HEX3 = d;

//define LPM COUNTER with asychronous
part4_LPM_COUNTER CR(~reset, clk, enable, Q); 

//HEX
reg [3:0] hex_digit[3:0];
reg [1:0] scan;

always@ (*)begin;//hexademical
	hex_digit[0] = Q[3:0];
	hex_digit[1] = Q[7:4];
	hex_digit[2] = Q[11:8];
	hex_digit[3] = Q[15:12];
end
//7 segment setup
function [6:0] hex_to_seg;
	input [3:0] hex;
	  case (hex)
			4'h0: hex_to_seg = 7'b1000000; // 0
			4'h1: hex_to_seg = 7'b1111001; // 1
			4'h2: hex_to_seg = 7'b0100100; // 2
			4'h3: hex_to_seg = 7'b0110000; // 3
			4'h4: hex_to_seg = 7'b0011001; // 4
			4'h5: hex_to_seg = 7'b0010010; // 5
			4'h6: hex_to_seg = 7'b0000010; // 6
			4'h7: hex_to_seg = 7'b1111000; // 7
			4'h8: hex_to_seg = 7'b0000000; // 8
			4'h9: hex_to_seg = 7'b0010000; // 9
			4'hA: hex_to_seg = 7'b0001000; // A
			4'hB: hex_to_seg = 7'b0000011; // B
			4'hC: hex_to_seg = 7'b1000110; // C
			4'hD: hex_to_seg = 7'b0100001; // D
			4'hE: hex_to_seg = 7'b0000110; // E
			4'hF: hex_to_seg = 7'b0001110; // F
		default: hex_to_seg = 7'b1000000; // 0
	 endcase
endfunction

//display
always @(posedge clk)begin
	a <= hex_to_seg(hex_digit[0]);
	b <= hex_to_seg(hex_digit[1]);
	c <= hex_to_seg(hex_digit[2]);
	d <= hex_to_seg(hex_digit[3]);

end

endmodule