`timescale 1ns / 1ps
module segament_selection_signal(
        input rst,
        input overt,
        input [3:0] bin,//四位表示当前时刻需要被输出的值
        output reg [7:0] seg //八位数码管显示信号
        );
        
        always @ (*)
            begin
                // 复位
                if(~rst)
                    seg = 8'b0000_0000;
                // 超时报警：4位数码管都显示8
                else if(overt == 1)
                    seg = 8'b0111_1111;
                // 计时器正常显示输出
                else 
                    begin
                        case(bin)
                            4'b0000:seg = 8'b0011_1111; //0
                            4'b0001:seg = 8'b0000_0110; //1
                            4'b0010:seg = 8'b0101_1011; //2
                            4'b0011:seg = 8'b0100_1111; //3
                            4'b0100:seg = 8'b0110_0110; //4
                            4'b0101:seg = 8'b0110_1101; //5
                            4'b0110:seg = 8'b0111_1101; //6
                            4'b0111:seg = 8'b0000_0111; //7
                            4'b1000:seg = 8'b0111_1111; //8
                            4'b1001:seg = 8'b0110_1111; //9
                            default:seg = 8'b0000_0000;
                        endcase
                    end
               end
endmodule