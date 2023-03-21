`timescale 1ns / 1ps

module calculate(X,A,B,C);
    //输入：0到15的二进制表示，对应X3X2X1X0
    input wire[3:0] X;
    //输出：输入数字平方根的3位二进制编码近似表示，对应ABC
    output wire A,B,C;

    wire  
    X3_n,X2_n,X1_n,X0_n,//输入数字的非
    A_1,A_2,//计算A的值所产生的中间变量
    B_1,B_2,B_3,B_4,B_5,B_6,
    C_1,C_2,C_3,C_4,C_5,C_6;

    //根据工艺映射后的电路，写出所需要用的非门和与非门                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    not
    not3(X3_n,X[3]),//与X[3]连接的非门
    not2(X2_n,X[2]),//与X[2]连接的非门
    not1(X1_n,X[1]),//与X[1]连接的非门
    not0(X0_n,X[0]),//与X[0]连接的非门
    not3_o(A,A_2);//输出到A的非门

    nand
    nandA_1(A_1,X0_n,X1_n),
    nandA_2(A_2,X[3],X[2],A_1),

    nandB_1(B_1,X[1],X[0]),
    nandB_2(B_2,X2_n,B_1),
    nandB_3(B_3,X3_n,B_2),
    nandB_4(B_4,X1_n,X0_n),
    nandB_5(B_5,B_4,X[2]),
    nandB_6(B_6,X[3],B_5),
    nandB_o(B,B_3,B_6),//输出到B的与非门

    nandC_1(C_1,X1_n,X[0]),
    nandC_2(C_2,X[1],X0_n),
    nandC_3(C_3,C_1,C_2),
    nandC_4(C_4,X2_n,C_3),
    nandC_5(C_5,X[3],B_5),
    nandC_6(C_6,X3_n,X[2],X[1],X[0]),
    nandC_7(C,C_4,C_5,C_6);//输出到C的与非门

endmodule
