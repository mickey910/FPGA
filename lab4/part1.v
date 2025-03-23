/* part1 8bit FSM*/
module part1 (SW, KEY, LEDR);
input [9:0] SW;
input [3:0] KEY;
output [9:0] LEDR;

parameter A = 9'b000000001;
parameter B = 9'b000000010;
parameter C = 9'b000000100;
parameter D = 9'b000001000;
parameter E = 9'b000010000;
parameter F = 9'b000100000;
parameter G = 9'b001000000;
parameter H = 9'b010000000;
parameter I = 9'b100000000;
reg [8:0]state, next_state;
reg [8:0] led;
reg z;

assign reset = SW[0];
assign in = SW[1];
assign clk = KEY[0];
assign w = SW[1]; 
assign LEDR[8:0] = led;
assign LEDR[9] = z;

/*state*/
always @(negedge clk)
begin
	if (reset)
		 state <= A;
	else
		state <= next_state;
end
/*FSM*/
always @(*)
begin
	case(state)
	A:begin
		led = A;
		z = 0;
		if(w ==0)
			next_state = B;
		else
			next_state = F;
	end
	B:begin
		led = B;
		z = 0;
		if(w ==0)
			next_state = C;
		else
			next_state = F;
	end
	C:begin
		led = C;
		z = 0;
		if(w ==0)
			next_state = D;
		else
			next_state = F;
	end
	D:begin
		led = D;
		z = 0;
		if(w ==0)
			next_state = E;
		else
			next_state = F;
	end
	E:begin
		led = E;
		z = 1;
		if(w ==0)
			next_state = E;
		else
			next_state = F;
	end
	F:begin
		led = F;
		z = 0;
		if(w ==0)
			next_state = B;
		else
			next_state = G;
	end
	G:begin
		led = G;
		z = 0;
		if(w ==0)
			next_state = B;
		else
			next_state = H;
	end
	H:begin
		led = H;
		z = 0;
		if(w ==0)
			next_state = B;
		else
			next_state = I;
	end
	I:begin
		led = I;
		z = 1;
		if(w ==0)
			next_state = B;
		else
			next_state = I;
	end
	endcase
end

endmodule