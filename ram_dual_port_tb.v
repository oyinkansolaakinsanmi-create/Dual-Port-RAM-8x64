module dual_port_ram_tb;
reg clk;
reg we_a, we_b;
reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
wire [7:0] q_a, q_b;

// Instantiate the DUT
dual_port_ram uut (
    .q_a(q_a),
    .q_b(q_b),
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize signals
    clk = 0;
    we_a = 0; we_b = 0;
    data_a = 8'h00; data_b = 8'h00;
    addr_a = 0; addr_b = 0;

    // Write to port A
    #10; we_a = 1; addr_a = 6'd10; data_a = 8'hAA;
    #10; we_a = 0;

    // Read from port A
    #10; addr_a = 6'd10;

    // Write to port B
    #10; we_b = 1; addr_b = 6'd20; data_b = 8'h55;
    #10; we_b = 0;

    // Read from port B
    #10; addr_b = 6'd20;

    // Simultaneous access test
    #10;
    we_a = 1; data_a = 8'hF0; addr_a = 6'd15;
    we_b = 1; data_b = 8'h0F; addr_b = 6'd15;  // Same address collision test
    #10;
    we_a = 0; we_b = 0;

    #10; addr_a = 6'd15; addr_b = 6'd15;

    #20;
    $stop;
end

endmodule
