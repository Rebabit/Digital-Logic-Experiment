//针对自动售货机时序电路的设计程序
`timescale 1ns / 1ps
module machine(CLK,RESET,X,Z);
    input CLK,RESET,X;
    output Z;
    reg[2:0] state,next_state;//当前状态、下一状态
    parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100;//状态的计数赋值
    reg Z;

//异步电路
always @(posedge CLK or posedge RESET)
begin 
    if (RESET)
        state <= S0;//复位，回到初始状态S0（用于初始化）
    else
        state <= next_state;//在时钟的上升沿转移状态
end

//下一状态的判断：若X为1则转移至下一状态，否则回到初始状态
always @(X or state)
begin 
    case (state)
        S0: next_state = X ? S1 : S0;
        S1: next_state = X ? S2 : S0;
        S2: next_state = X ? S3 : S0;
        S3: next_state = X ? S4 : S0;
        S4: next_state = X ? S1 : S0;
    endcase
end

//输出：当且仅当连续投入4个硬币，输出为1 
always @(X or state)
begin 
    case (state)
        S0: Z = 1'b0;
        S1: Z = 1'b0;
        S2: Z = 1'b0;
        S3: Z = 1'b0;
        S4: Z = 1'b1;// Moore型输出
    endcase
end
endmodule
