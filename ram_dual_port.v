module ram_dual_port (
    output reg [7:0] q_a, q_b,     // Output data for ports A and B
    input      [7:0] data_a, data_b, // Input data for write operations
    input      [5:0] addr_a, addr_b, // 6-bit address for 64 locations
    input            we_a, we_b,     // Write-enable signals
    input            clk             // Clock input
);

    // 64 x 8-bit memory array
    reg [7:0] ram [63:0];

    // Port A: synchronous read/write
    always @(posedge clk) begin
        if (we_a) begin
            ram[addr_a] <= data_a;
            q_a <= data_a;           // Write-through behavior
        end else begin
            q_a <= ram[addr_a];      // Read operation
        end
    end

    // Port B: synchronous read/write
    always @(posedge clk) begin
        if (we_b) begin
            ram[addr_b] <= data_b;
            q_b <= data_b;
        end else begin
            q_b <= ram[addr_b];
        end
    end

endmodule
