module elevator_fsm (
  input wire clk,
  input wire reset,
  input wire up_button,
  input wire down_button,
  output reg motor_up,
  output reg motor_down,
  output reg open_door,
  output reg close_door,
  output reg [3:0] floor
);

  // Define the state variables
  reg [1:0] state;
  reg [1:0] next_state;
  
  floor_display OurFloor (
	.clk(clk),
	.reset(reset),
	.floor(floor),
	.display()
  );

  // State register
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Initial state: IDLE
    else
      state <= next_state;
  end

  // Next state and output logic
  always @(state or up_button or down_button) begin
    case (state)
      2'b00: // IDLE
        if (up_button) begin
          next_state = 2'b01; // UP
          motor_up = 1;
          motor_down = 0;
          open_door = 0;
          close_door = 1;
        end
        else if (down_button) begin
          next_state = 2'b10; // DOWN
          motor_up = 0;
          motor_down = 1;
          open_door = 0;
          close_door = 1;
        end
        else begin
          next_state = 2'b00; // IDLE
          motor_up = 0;
          motor_down = 0;
          open_door = 1;
          close_door = 0;
        end
      2'b01: // UP
        if (down_button) begin
          next_state = 2'b10; // DOWN
          motor_up = 0;
          motor_down = 1;
          open_door = 0;
          close_door = 1;
        end
        else if (up_button) begin
          next_state = 2'b01; // UP
          motor_up = 1;
          motor_down = 0;
          open_door = 0;
          close_door = 1;
        end
        else begin
          next_state = 2'b00; // IDLE
          motor_up = 0;
          motor_down = 0;
          open_door = 1;
          close_door = 0;
        end
      2'b10: // DOWN
        if (up_button) begin
          next_state = 2'b01; // UP
          motor_up = 1;
          motor_down = 0;
          open_door = 0;
          close_door = 1;
        end
        else if (down_button) begin
          next_state = 2'b10; // DOWN
          motor_up = 0;
          motor_down = 1;
          open_door = 0;
          close_door = 1;
        end
        else begin
          next_state = 2'b00; // IDLE
          motor_up = 0;
          motor_down = 0;
          open_door = 1;
          close_door = 0;
        end
      default:
		 begin
        next_state = 2'b00; // IDLE
        motor_up = 0;
        motor_down = 0;
        open_door = 1;
        close_door = 0;
		  end
    endcase
  end

  // Assign current floor to the output port
  always @(posedge clk) begin
    case (state)
      2'b00: floor = 4'b0000; // IDLE (Floor 0)
      2'b01: floor = 4'b0001; // UP (Floor 1)
      2'b10: floor = 4'b0010; // DOWN (Floor 2)
      // Add more floor cases as needed
      default: floor = 4'bXXXX; // Invalid floor
    endcase
  end

endmodule


