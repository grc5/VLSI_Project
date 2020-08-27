module ahb_slave_tb ();

reg [31:0] Hwdata,Haddr;
reg [1:0] Htrans;
reg Hreadyin,Hclk,Hreset;
reg Valid;
reg Hwrite_reg;
reg [2:0]Tempselx;
reg [31:0] Haddr1,Haddr2,Hdata1,Hdata2;

ahb_slave a_s(.Hwdata(Hwdata),.Haddr(Haddr),.Htrans(Htrans),.Hreadyin(Hreadyin),.Hclk(Hclk),.Hreset(Hreset),
.Valid(Valid),.Hwrite_reg(Hwrite_reg),.Tempselx(Tempselx),.Haddr1(Haddr1),.Haddr2(Haddr2),.Hdata1(Hdata1),.Hdata2(Hdata2));

/*initial
begin
Hclk = 0
forever #10 Hclk = ~Hclk;
end

task reset();
begin
@(negedge Hclk)
Hreset = 1;
@(negedge Hclk)
Hreset = 0;
end
endtask

initial
begin
#2;
Haddr = {$random} %256;
Hwdata = {$random} %256;*/



endmodule
