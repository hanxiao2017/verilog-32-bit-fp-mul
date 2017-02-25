`timescale 1ns/1ns

`define N_TESTS 10000

module main_tb;

	logic clk = 0;

	logic[31:0] a;
	logic[31:0] b;
	logic[31:0] y;
	logic[31:0] exp_y;

	logic[95:0] testVector[`N_TESTS:0];

	int test_n = 0, cycle_n = 0, errors = 0;

	fp_mul DUT(clk, a, b, y);

	initial  begin 
		$readmemb("TestVector", testVector);
	end 

	always @(posedge clk) begin

		// every two cycles...
		if(cycle_n % 2 == 0) begin

			// check if result matches excepted result
			$display("Test:%d", test_n);
			$display("Expected = %b", exp_y);
			$display("Computed = %b", y);

			if(y !== exp_y)	begin 
				$display("Diff.    = %b", y^exp_y);
				errors++;
			end
			
			if (test_n >= `N_TESTS) begin
				$display("Completed %d tests, %d passes and %d fails.", 
						test_n, test_n-errors, errors);		
			end

			// then load next test values
			{a, b, exp_y} = testVector[test_n];
			test_n++;
		end 

		cycle_n++;
	end

	always begin
		clk = !clk; #5;
	end


endmodule 