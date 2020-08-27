`include "D:/VLSI_Project/RTL/define.v"

module bridge_top_tb();

reg Hclk,Hreset;
wire [31:0]Hrdata,Haddr,Hwdata,Paddr,Pwdata,Paddr_out,Pwdata_out,Prdata;
wire [1:0]Hresp,Htrans;
wire Hreadyout,Hreadyin,Hwrite,Pwrite,Penable,Pwrite_out,Penable_out;
wire [2:0]Pselx,Pselx_out;

assign Hrdata = Prdata;

ahb_master a_m(.Hclk(Hclk),.Hreset(Hreset),.Hreadyout(Hreadyout),.Hrdata(Hrdata),.Hresp(Hresp),.Htrans(Htrans),.Haddr(Haddr),.Hwdata(Hwdata),
.Hreadyin(Hreadyin),.Hwrite(Hwrite));

apb_interface apb_int(.Pwrite(Pwrite),.Penable(Penable),.Paddr(Paddr),.Pwdata(Pwdata),.Pselx(Pselx),.Pselx_out(Pselx_out),.Penable_out(Penable_out),
.Paddr_out(Paddr_out),.Pwdata_out(Pwdata_out),.Pwrite_out(Pwrite_out),.Prdata(Prdata));

bridge_top top_blk(.Hwdata(Hwdata),.Haddr(Haddr),.Htrans(Htrans),.Hreadyin(Hreadyin),.Hclk(Hclk),.Hreset(Hreset),.Hwrite(Hwrite),
.Hrdata(Hrdata),.Prdata(Prdata),.Pselx(Pselx),.Paddr(Paddr),.Pwdata(Pwdata),.Penable(Penable),.Pwrite(Pwrite),.Hreadyout(Hreadyout));

//.pselx_temp(Pselx),.paddr_temp(Paddr),.pwdata_temp(Pwdata),.penable_temp(Penable),.pwrite_temp(Pwrite),.hreadyout_temp(Hreadyout));

//.Pselx(pselx_temp),.Paddr(paddr_temp),.Pwdata(pwdata_temp),.Penable(penable_temp),.pwrite(pwrite_temp),.Hreadyout(hreadyout_temp));
//.Pselx(Pselx),.Paddr(Paddr),.Pwdata(Pwdata),.Penable(Penable),.Pwrite(Pwrite),.Hreadyout(Hreadyout));

//parameter BYTE = 3'b000,HALFWORD = 3'b001,WORD = 3'b010;
//parameter SINGLE = 3'b000,INCR = 3'b001,WRAP4 = 3'b010,INCR4 = 3'b011,WRAP8 = 3'b100,INCR8 = 3'b101,WRAP16 = 3'b110,INCR16 = 3'b111;

initial
begin
Hclk = 1;
forever #10 Hclk = ~Hclk;
end

task delay();
begin
#20;//@(negedge Hclk)
Hreset = 0;
#20;//@(negedge Hclk)
Hreset = 1;
end
endtask

initial
begin
delay;
a_m.single_write;
/*//top_blk;
#100;
a_m.single_read;
//top_blk;
#100;*/
a_m.hburst_write(`INCR8 , `BYTE);
//#100;
a_m.single_read;
//#100;
//a_m.single_write;
//#100;
end

initial
begin
#1000 $finish;
end


endmodule
