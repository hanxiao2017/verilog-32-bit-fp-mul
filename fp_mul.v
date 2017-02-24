/*   Input and outputs are in single-precision IEEE 754 FP format:
     Sign     -   1 bit, position 32
     Exponent -  8 bits, position 31-24
     Mantissa - 23 bits, position 22-1

Not implemented: special cases like inf, NaN
BUG: rounding mantissa isn't working, get incorrect LSB about 30% of the time
     if you spot my error, please let me know!
*/

// indices of components of IEEE 754 FP
`define SIGN   	31
`define EXP    	30:23
`define M    	22:0

`define P    	24    // number of bits for mantissa (including 
`define G    	23    // guard bit index
`define R    	22    // round bit index
`define S    	21:0  // sticky bits range

`define BIAS   	127


module fp_mul(input wire[31:0] a,
              input wire[31:0] b,
              output reg[31:0] y);

    reg [`P-2:0] m;
    reg [7:0] e;
    reg s;
    
    reg [`P*2-1:0] product;
    reg G;
    reg R;
    reg S;
    reg shift;

	always @(a, b) begin

		// if either mantissa is 0, result is zero
		if(!a[`M] | !b[`M]) 
			y = 32'b0;
		else begin
			// sign is xor of signs
			s = a[`SIGN] ^ b[`SIGN];

			// mantissa is product of a and b's mantissas, 
			// with a 1 added as the MSB to each
			product = {1'b1, a[`M]} * {1'b1, b[`M]};
		
			// if the MSB of the resulting product is 0
			// normalize by shifting right    
			shift = product[47];
			if(!product[47]) product = product << 1; 
		
			// implement nearest-even rounding 
			// BUG: LSB bit is sometimes incorrect. 
			//      Unsure what mistake I'm making here.
			G = product[`G]; 
			R = product[`R];
			S = |product[`S]; // OR together all bits right of R
			m = product[46:24] + (G & (R | S));
			
			// exponent is sum of a and b's exponents, minus the bias 
			// if the mantissa was shifted, increment the exponent to balance it
			e = a[`EXP] + b[`EXP] - `BIAS + shift;
		
			y = {s, e, m}; 
		end
	end

endmodule