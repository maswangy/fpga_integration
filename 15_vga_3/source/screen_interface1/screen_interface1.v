module screen_interface1
(
    input clk,
    input rst_n,
    input [10:0] c1,
    input [10:0] c2,
    input [7:0] hp,
    input [7:0] maxhp,
    output [2:0]rgb
);

    wire wr_en;
    wire [10:0] wr_addr;
    wire [7:0]  wr_data;

    screen_control u1
    (
        .clk(clk),
        .rst_n(rst_n),
        .hp(hp),
        .maxhp(maxhp),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .wr_data(wr_data)
    );
    
    wire [10:0] ram_addr;
    wire [7:0]  ram_data;
    
    ram_module u2
    (
        .clk(clk),
        // .rst_n(rst_n),
        .write_en(wr_en),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .rd_addr(ram_addr),
        .rd_data(ram_data)
    );


    vga_control_2 u3
    (
        .clk(clk),
        .rst_n(rst_n),
        .c1(c1),
        .c2(c2),
        .rgb(rgb),
        .ram_addr(ram_addr),
        .ram_data(ram_data)
    );
    
endmodule

