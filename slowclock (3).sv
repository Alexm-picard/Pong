module slowclock(input wire fastclk,
                 input wire reset,
                 output reg slowclk) ;

   // Register block
   reg [22:0]                count; // State of the D-ffs
   wire [22:0]               d; // Input to the D-ffs
   always_ff @(posedge fastclk or posedge reset)
     begin
        if (reset) begin
           count <= 23'b0;
        end else begin
           count <= d;
        end
     end


   // input + current state -> ff input block
   assign d = (count == 23'd5000000) ? 23'b0 : count + 23'b1;

   // current state -> output block
   always_comb
     begin
        if (count == 23'b0)
          slowclk = 1'b1;
        else
          slowclk = 1'b0;
     end

endmodule