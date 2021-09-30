module add_sub_4b (input logic [3:0] a,b,		// operands
		   input logic cin,			// carry_in
		   input logic ctrl,			// ADD(ctrl=0) and SUB(ctrl=1)
		   output logic [3:0] s,		// The result of ADD/SUB
		   output logic cout			// carry_out
);

wire p0,g0,p1,p2,p3,g3;
wire c4,c3,c2,c1;
reg [3:0] B;  // Stroing the value of "b" based on the "ctrl"

assign B = (ctrl==0) ?   b : // if ctrl = 0, B = b
           (ctrl==1) ?  -b :  // if ctrl = 1, B = -b (two's compliment for subtraction)
                       'bx ; 

// compute p for each stage
 assign p0 = a[0]^B[0],
     p1 = a[1]^B[1],
     p2 = a[2]^B[2],
     p3 = a[3]^B[3];
 // compute g for each stage
 assign g0 = a[0]&B[0],
	g1 = a[1]&B[1],
	g2 = a[2]&B[2],
	g3 = a[3]&B[3];
 // compute carry for each stage
 // c0 = cin in arithmetic equation for CLA
 assign c1 = g0|(p0&cin),
	c2 = g1|(p1&g0)|(p1&p0&cin),
	c3 = g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&cin),
	c4 = g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&cin);
// compute sum
assign  s[0] = p0^cin,
	s[1] = p1^c1,
	s[2] = p2^c2,
	s[3] = p3^c3;
// assign carry
assign cout = c4;

endmodule