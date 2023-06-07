`timescale 1ns/1ps

module floor_display_tb;

  // Inputs
  reg clk;
  reg reset;
  reg [3:0] floor;

  // Outputs
  wire [3:0] display;

  // Instantiate the module under test
  floor_display dut (
    .clk(clk),
    .reset(reset),
    .floor(floor),
    .display(display)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    clk = 0;
    reset = 1;
    floor = 4'b0000;
    #10 reset = 0;

    // Test floor 0
    floor = 4'b0000;
    #20;
    
    // Test floor 1
    floor = 4'b0001;
    #20;
    
    // Test floor 2
    floor = 4'b0010;
    #20;
    
    // Test floor 3
    floor = 4'b0011;
    #20;
    
    // Test floor 4
    floor = 4'b0100;
    #20;
    
    // Test invalid floor
    floor = 4'b0101;
    #20;
    
    $finish;
  end

endmodule
