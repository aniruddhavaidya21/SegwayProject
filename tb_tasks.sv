/*
*This file contains all the tasks/functions used in the Segway Project.
*/

//This task intalize the tests.
task automatic Initialize;
  ref clk, RST_n, send_cmd, OVR_I_lft, OVR_I_rght;
  ref logic [7:0] cmd;
  ref logic [11:0] ld_cell_lft, ld_cell_rght, steerPot, batt;
  ref logic signed [15:0] rider_lean;

  clk = 0;
  RST_n = 0;
  cmd = 8'h00;
  send_cmd = 0;
  rider_lean = 16'h0000;
  ld_cell_lft = 12'h000;
  ld_cell_rght = 12'h000;
  steerPot = 12'h000;
  batt = 12'h000;
  OVR_I_lft = 0; 
  OVR_I_rght = 0;
  @(posedge clk);
  @(negedge clk);
    RST_n = 1; 
endtask

//Used to send the command to UART
task automatic SendCmd(input byte command, ref clk, send_cmd, ref logic [7:0] cmd);
	//ref clk, send_cmd;
	//ref logic [7:0] cmd;
	@(negedge clk);
	
	cmd = command;
	send_cmd  = 1;
	@(posedge clk);
	@(negedge clk);
	send_cmd = 0;

endtask

//Task used to check values based on the actual value, expected value and the name of what the value is getting compared to.
task check_value(integer expected, integer actual, string signal_name, string test_name);
	if(actual !== expected) begin
		$display("Error - Test Name: %s, Signal Name: %s, Actual Value: %h, Expected Value: %h", test_name, signal_name, actual, expected);
		$stop();
	end
endtask

//Task to check the theta of the platform
task check_theta_platorm(integer expected, integer actual, string signal_name, string test_name);
	if(actual !== expected) begin
		$display("Error - Test Name: %s, Signal Name: %s, Actual Value: %h, Expected Value: %h", test_name, signal_name, actual, expected);
		$stop();
	end
endtask
