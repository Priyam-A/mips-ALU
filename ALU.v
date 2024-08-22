module ALU(input [31:0] aluIn1, input [31:0] aluIn2, input [3:0]ALUContrl, output reg [31:0]aluOut, output reg zero);
always @(*) begin
if(ALUContrl==4'b0010)
aluOut = aluIn1 + aluIn2;
else if (ALUContrl==4'b0110)
aluOut = aluIn1 - aluIn2;
else if (ALUContrl == 4'b0000)
aluOut = aluIn1 & aluIn2;
else if (ALUContrl == 4'b0001)
aluOut = aluIn1 | aluIn2;
else if(ALUContrl == 4'b0111)
begin
  if (aluIn1 < aluIn2)
  aluOut = 32'b1;
  else
  aluOut = 32'b0;
end

if(aluOut==32'b0)
zero = 1'b1;
else
zero = 1'b0;
end
endmodule

module aluCtrl(input [1:0] aluOp, input [5:0] func, output reg [3:0] ALUContrl);

always @(*) begin
if (aluOp[0] == 1'b1)
  ALUContrl = 4'b0110;
else if (aluOp == 2'b00)
  ALUContrl = 4'b0010;
else if(aluOp[1] == 1'b1)
  begin
    if(func[3:0] == 4'b0000)
      ALUContrl = 4'b0010;
    else if (func[3:0] == 4'b0010)
      ALUContrl = 4'b0110;
    else if(func[3:0] == 4'b0100)
      ALUContrl = 4'b0000;
    else if(func[3:0] == 4'b0101)
      ALUContrl = 4'b0001;
    else if(func[3:0] == 4'b1010)
      ALUContrl = 4'b0111;
  end
end
endmodule

module testbench();

  reg [31:0] aluIn1, aluIn2;
  reg [1:0] aluOp;
  reg [5:0] func;

  
  wire [31:0]aluOut;
  wire [3:0]ALUContrl;
  wire zero;
  
  
  aluCtrl ctrl(aluOp,func,ALUContrl);
  ALU uut(aluIn1, aluIn2, ALUContrl,aluOut,zero);

  initial
  begin
    aluOp        = 2'd0;
    func         = 6'd0;
    aluIn1       = 32'b0;
    aluIn2       = 32'b0;

    $dumpfile("2022AAPS1174G_Alu_Control_CA_Lab-2.vcd"); //put your CampusID here
    $dumpvars(0, testbench);
    //define all test cases given in the PDF file.
    //ADD, SUB, AND, OR and SLT
    //Change the operation after every 10 unit of time.
    //WRITE YOUR CODE HERE.

    
    aluOp = 2'b00; func = 6'd0;
    aluIn1 = 32'd10; aluIn2 = 32'd20;
    #10;

    
    aluOp = 2'b01; func = 6'd0;
    aluIn1 = 32'd30; aluIn2 = 32'd20;
    #10;

    
    aluOp = 2'b10; func = 6'b000100;
    aluIn1 = 32'd15; aluIn2 = 32'd8;
    #10;

    
    aluOp = 2'b10; func = 6'b000101;
    aluIn1 = 32'd5; aluIn2 = 32'd10;
    #10;

    
    aluOp = 2'b10; func = 6'b001010;
    aluIn1 = 32'd5; aluIn2 = 32'd10;
    #10;

    
    aluOp = 2'b10; func = 6'b001010;
    aluIn1 = 32'd15; aluIn2 = 32'd10;
    #10;
    $finish;
  end
endmodule

