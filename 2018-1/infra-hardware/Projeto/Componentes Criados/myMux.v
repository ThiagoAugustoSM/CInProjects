//MuxMem e MuxPC========================================
module mux_31_2(
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [1:0] sel,
    
    output reg [31:0]out
);
    always @(sel or in0 or in1 or in2 or in3) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;
   		 2: out = in2;
   		 3: out = in3;
   	 endcase
    end
endmodule

module mux_31_2_testbench();
    reg [31:0] in0;
    reg [31:0] in1;
    reg [31:0] in2;
    reg [31:0] in3;
    
    reg [1:0] sel;
    wire [31:0] out;
    
    mux_31_2 DUT(in0, in1, in2, in3, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 0; in3 = 0; sel = 0;
   	 #(100) in0 = 72;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//=============================================
//MuxAluSourceA
module mux_31_1(
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire sel,
    
    output reg [31:0]out
);
    always @(*) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;

   	 endcase
    end
endmodule

module mux_31_1_testbench();
    reg [31:0] in0;
    reg [31:0] in1;
    reg  sel;
    wire [31:0] out;
    
    mux_31_1 DUT(in0, in1, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; sel = 0;
   	 #(100) in0 = 72;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===============================================


//MuxAluSourceB==================================
module mux_31_3(
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [31:0] in4,
    input wire [31:0] in5,

    input wire [2:0] sel,
    
    output reg [31:0]out
);
    always @(*) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;
   		 2: out = in2;
   		 3: out = in3;
   		 4: out = in4;
   		 5: out = in5;


   	 endcase
    end
endmodule

module mux_31_3_testbench();
    reg [31:0] in0;
    reg [31:0] in1;
    reg [31:0] in2;
    reg [31:0] in3;
    reg [31:0] in4;
    reg [31:0] in5;


    reg  [2:0] sel;
    wire [31:0] out;
    
    mux_31_3 DUT(in0, in1, in2, in3, in4, in5, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 0; in3 = 0; in4 = 0; in5 = 0;  sel = 0;
   	 #(100) in0 = 72;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===================================

module mux_4_2_testbench();
    reg [4:0] in0;
    reg [4:0] in1;
    reg [4:0] in2;
    


    reg  [1:0] sel;
    wire [4:0] out;
    
    mux_4_3 DUT(in0, in1, in2, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 0;  sel = 0;
   	 #(100) in0 = 5;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===================================

//MuxReg2==================================
module mux_5_2(
    input wire [4:0] in0,
    input wire [4:0] in1,
    input wire [4:0] in2,


    input wire [1:0] sel,
    
    output reg [4:0]out
);
    always @(*) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;
   		 2: out = in2;


   	 endcase
    end
endmodule

module mux_5_2_testbench();
    reg [4:0] in0;
    reg [4:0] in1;
    reg [4:0] in2;
    


    reg  [1:0] sel;
    wire [4:0] out;
    
    mux_5_2 DUT(in0, in1, in2, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 0;  sel = 0;
   	 #(100) in0 = 5;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===================================

//MuxRegDST==================================
module mux_5_3(
    input wire [4:0] in0,
    input wire [4:0] in1,
    input wire [4:0] in2,
    input wire [4:0] in3,
    input wire [4:0] in4,


    input wire [2:0] sel,
    
    output reg [4:0]out
);
    always @(*) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;
   		 2: out = in2;
   		 3: out = in3;
   		 4: out = in4;

   	 endcase
    end
endmodule

module mux_5_3_testbench();
    reg [4:0] in0;
    reg [4:0] in1;
    reg [4:0] in2;
    reg [4:0] in3;
    reg [4:0] in4;
    


    reg  [2:0] sel;
    wire [4:0] out;
    
    mux_5_3 DUT(in0, in1, in2, in3, in4, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 29; in3 = 30; in4 = 31; sel = 0;
   	 #(100) in0 = 5;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===================================

//MuxBranchDec==================================
module mux_1_2(
    input wire  in0,
    input wire  in1,
    input wire  in2,
    input wire  in3,


    input wire [1:0] sel,
    
    output reg out
);
    always @(*) begin
   	 case (sel)
   		 0: out = in0;
   		 1: out = in1;
   		 2: out = in2;
   		 3: out = in3;

   	 endcase
    end
endmodule

module mux_1_2_testbench();
    reg  in0;
    reg  in1;
    reg  in2;
    reg  in3;
    

    reg  [1:0] sel;
    wire  out;
    
    mux_1_2 DUT(in0, in1, in2, in3, sel, out);
    initial begin
   	 in0 = 0; in1 = 0; in2 = 0; in3 = 0; sel = 0;
   	 #(100) in0 = 1;
   	 #(100) sel = 0;
   	 #(100) sel = 1;
   	 
    end
endmodule
//===================================
 
