/*part4*/
module part4 (SW, KEY, HEX0);
input [9:0] SW;
input [3:0] KEY;
output reg[6:0] HEX0;

reg [3:0]state, next_state;

assign clk = KEY[0];
assign reset = SW[0];
reg [1:0] sw;

parameter A = 4'd0;
parameter B = 4'd1;
parameter C = 4'd2;
parameter D = 4'd3;
parameter E = 4'd4;
parameter F = 4'd5;
parameter G = 4'd6;
parameter H = 4'd7;
parameter I = 4'd8;
parameter J = 4'd9;

always @(negedge clk)begin
	if(reset)
		state <= A;	
	else
		state <= next_state;
end
always @(*)begin
	sw = SW[2:1];
	case(state)
		A:begin
			if(sw == 2'b00)
				next_state = A;
			else if(sw == 2'b01)
				next_state = B;
			else if(sw == 2'b10)
				next_state = C;
			else
				next_state = J;
		end
		B:begin
			if(sw == 2'b00)
				next_state = B;
			else if(sw == 2'b01)
				next_state = C;
			else if(sw == 2'b10)
				next_state = D;
			else
				next_state = A;
		end
		C:begin
			if(sw == 2'b00)
				next_state = C;
			else if(sw == 2'b01)
				next_state = D;
			else if(sw == 2'b10)
				next_state = E;
			else
				next_state = B;
		end
		D:begin
			if(sw == 2'b00)
				next_state = D;
			else if(sw == 2'b01)
				next_state = E;
			else if(sw == 2'b10)
				next_state = F;
			else
				next_state = C;
		end
		E:begin
			if(sw == 2'b00)
				next_state = E;
			else if(sw == 2'b01)
				next_state = F;
			else if(sw == 2'b10)
				next_state = G;
			else
				next_state = D;
		end
		F:begin
			if(sw == 2'b00)
				next_state = F;
			else if(sw == 2'b01)
				next_state = G;
			else if(sw == 2'b10)
				next_state = H;
			else
				next_state = E;
		end
		G:begin
			if(sw == 2'b00)
				next_state = G;
			else if(sw == 2'b01)
				next_state = H;
			else if(sw == 2'b10)
				next_state = I;
			else
				next_state = F;
		end
		H:begin
			if(sw == 2'b00)
				next_state = H;
			else if(sw == 2'b01)
				next_state = I;
			else if(sw == 2'b10)
				next_state = J;
			else
				next_state = G;
		end
		I:begin
			if(sw == 2'b00)
				next_state = I;
			else if(sw == 2'b01)
				next_state = J;
			else if(sw == 2'b10)
				next_state = A;
			else
				next_state = H;
		end
		J:begin
			if(sw == 2'b00)
				next_state = J;
			else if(sw == 2'b01)
				next_state = A;
			else if(sw == 2'b10)
				next_state = B;
			else
				next_state = I;
		end	
	endcase
end

//HEX
always @(*)begin
	case(state)
		4'd0: HEX0 = 7'b1000000; // 0
		4'd1: HEX0 = 7'b1111001; // 1
		4'd2: HEX0 = 7'b0100100; // 2
		4'd3: HEX0 = 7'b0110000; // 3
		4'd4: HEX0 = 7'b0011001; // 4
		4'd5: HEX0 = 7'b0010010; // 5
		4'd6: HEX0 = 7'b0000010; // 6
		4'd7: HEX0 = 7'b1111000; // 7
		4'd8: HEX0 = 7'b0000000; // 8
		4'd9: HEX0 = 7'b0010000; // 9
		default: HEX0 = 7'b1000000;
	endcase
end
endmodule