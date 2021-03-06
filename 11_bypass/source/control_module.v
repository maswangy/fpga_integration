module control_module
(
    input clk,
    input rst_n,
    
    input start_sig,
    output reg done_sig,
    
    
    output reg [3:0] rom_addr,
    output reg write_en,
    output reg [3:0] ram_addr
);


    reg [1:0] i;
    reg [4:0] x;
    reg [4:0] index;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
        begin
            i <= 2'd0;
            x <= 5'd0;
            index <= 5'd0;
            done_sig <= 1'b0;
            rom_addr <= 4'd0;
            write_en <= 1'b0;
            ram_addr <= 4'd0;
        end
        else if(start_sig)
        begin
            case(i)
                
                /*
                 * if(x == 16) 步骤0将逗留17个clk
                 * write_en信号有效为16个clk, write_en信号无效为1个clk,这就是为什么步骤0必须逗留17个clk
                 * write_en有效下x计数1~16, rom_addr和ram_addr取得为x的过去值,即0~15
                 */
                 
                0:
                if(x == 16) begin x <= 5'd0; write_en <= 1'b0; i <= i + 1'b1; end
                else begin x <= x + 1'b1; rom_addr <= x[3:0]; ram_addr <= x[3:0]; write_en <= 1'b1; end
                
                
                1:
                begin done_sig <= 1'b1; i <= i + 1'b1; end
                
                2:
                begin done_sig <= 1'b0; i <= 2'd0; end
            
            endcase
        end
    end
    
    
    
endmodule

