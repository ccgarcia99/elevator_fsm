module floor_display (
  input wire clk,
  input wire reset,
  input wire [3:0] floor,
  output reg [3:0] display
);

  // Register for storing the floor value
  reg [3:0] current_floor;

  always @(posedge clk or posedge reset) begin
    if (reset)
      current_floor <= 4'b0000; // Initial floor: 0
    else
      current_floor <= floor;
  end

  // Output display
  always @(current_floor) begin
    case (current_floor)
      4'b0000: display = 4'b0000; // Floor 0
      4'b0001: display = 4'b0001; // Floor 1
      4'b0010: display = 4'b0010; // Floor 2
      4'b0011: display = 4'b0011; // Floor 3
      4'b0100: display = 4'b0100; // Floor 4
      // Add more floor cases as needed
      default: display = 4'bXXXX; // Invalid floor
    endcase
  end

endmodule