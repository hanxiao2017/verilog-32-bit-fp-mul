`timescale 1ns/1ns

`define N_TESTS 10000

module main_tb;

logic clk;

logic[31:0] a;
logic[31:0] b;
logic[31:0] y;
logic[31:0] exp_y;

logic[95:0] testVector[`N_TESTS:0];

int i = 0, errors = 0, one_bit_rounding_errors = 0;

fp_mul DUT(a, b, y);


initial  begin 
	$readmemb("TestVector", testVector);
	i = 0; 
end 


always @(posedge clk) begin
	{a, b, exp_y} = testVector[i];
end


always @(negedge clk) begin

	if(y !== exp_y)	begin 
		errors++;
		$display("Test:%d", i);
		$display("Expected = %b", exp_y);
		$display("Computed = %b", y);
		$display("Diff.    = %b", y^exp_y);
	end


	if(y + 1 == exp_y | y - 1 == exp_y) begin 
		one_bit_rounding_errors++;  
	end


 	if (i >= `N_TESTS - 1) begin
		$display("Completed %d tests, %d passes and %d fails.", i, i-errors, errors);		
		$display("Of the fails, %d had a LSB off by one", one_bit_rounding_errors);
	end


	i++;
end


always begin
	clk <= 1; #5;
	clk <= 0; #5;
end


endmodule 