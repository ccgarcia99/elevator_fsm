`timescale 1ns/1ps

module elevator_fsm_tb;

  // Inputs
  reg clk;
  reg reset;
  reg up_button;
  reg down_button;

  // Outputs
  wire motor_up;
  wire motor_down;
  wire open_door;
  wire close_door;

  // Instantiate the FSM module
  elevator_fsm dut (
    .clk(clk),
    .reset(reset),
    .up_button(up_button),
    .down_button(down_button),
    .motor_up(motor_up),
    .motor_down(motor_down),
    .open_door(open_door),
    .close_door(close_door)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initial values
  initial begin
    clk = 0;
    reset = 1;
    up_button = 0;
    down_button = 0;

    // Reset the module
    #10 reset = 0;
  end

  // Stimulus
  always begin
    // Scenario 1: Press up button
    up_button = 1;
    #20 up_button = 0;

    // Scenario 2: Press down button
    down_button = 1;
    #20 down_button = 0;

    // Scenario 3: Press up and down buttons simultaneously
    up_button = 1;
    down_button = 1;
    #20 up_button = 0;
    down_button = 0;

    // Add more test scenarios here as needed

    // End simulation
    #10 $finish;
  end

endmodule
