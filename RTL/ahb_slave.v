`include "define.v"
module ahb_slave (Hreset,Hreadyin,Htrans,Haddr,Hwdata,Hwrite,Hclk,Valid,Hwrite_reg,Tempselx,Haddr1,Haddr2,Hdata1,Hdata2);

input [31:0]Hwdata,Haddr;
//input [31:0]Haddr;
input [1:0]Htrans;
input Hreadyin,Hwrite,Hclk,Hreset;
//input [2:0]Hsize;
output reg Valid;//Hwrite_reg;
output reg [31:0]Hdata1,Hdata2,Haddr1,Haddr2;
output reg Hwrite_reg;
output [2:0] Tempselx;

//parameter IDLE = 2'b00,BUSY = 2'b01,NONSEQ = 2'b10,SEQ = 2'b11;
//parameter depth = 2^32;
reg [1:0] present_state, next_state;
//wire [2:0]Tempselx;
//ahb_slave as(.Hreset(Hreset),.Hreadyin(Hreadyin),.Htrans(Htrans),.Haddr(Haddr),.Hwdata(Hwdata),.Hwrite(Hwrite),.Hclk(Hclk),.Valid(Valid),.Tempselx(Tempselx));
//reg [(width-1)] : 0] mem [(depth-1) : 0];

always @(posedge Hclk or negedge Hreset)
	begin
	if (!Hreset)
	begin
	Hdata1 <= 0;
	Hdata2 <= 0;
	Hwrite_reg <= 0;
	Haddr1 <= 0;
	Haddr2 <= 0;
	present_state <= `IDLE;
	//Valid <= 0;
	end
	//Valid = 0;
	else 
	begin
	present_state <= next_state;
	Haddr1 <= Haddr;
	Haddr2 <= Haddr1;
	Hwrite_reg <= Hwrite;
	

//always @(
	//if (Hwrite == 1)
	//begin
	Hdata1 <= Hwdata;
	Hdata2 <= Hdata1; 
	end
	end

always @ (Htrans,present_state)
	//present_state <= next_state;
	//else if (Htrans) 
	begin
	case (present_state)
	//begin
	`IDLE : if (Htrans==2'b01)
	next_state = `BUSY;
	else if (Htrans==2'b10)
	next_state = `NONSEQ;
	else if (Htrans==2'b11)
	next_state = `SEQ;
	else next_state <= `IDLE;

	`BUSY : if (Htrans==2'b00)
	next_state = `IDLE;
	else if (Htrans==2'b10)
	next_state = `NONSEQ;
	else if (Htrans==2'b11)
	next_state = `SEQ;
	else next_state <= `BUSY;

	`NONSEQ : if (Htrans==2'b00)
	next_state = `IDLE;
	else if (Htrans==2'b01)
	next_state = `BUSY;
	else if (Htrans==2'b11)
	next_state = `SEQ;
	else next_state <= `NONSEQ;

	`SEQ : if (Htrans==2'b00)
	next_state = `IDLE;
	else if (Htrans==2'b01)
	next_state = `BUSY;
	else if (Htrans==2'b10)
	next_state = `NONSEQ;
	else next_state <= `SEQ;

//	default : next_state = IDLE;

	endcase
	end

assign Tempselx[0] = (Haddr >= 32'h80000000) && (Haddr <= 32'h83FFFFFF);
assign Tempselx[1] = (Haddr >= 32'h84000000) && (Haddr <= 32'h87FFFFFF);
assign Tempselx[2] = (Haddr >= 32'h88000000) && (Haddr <= 32'h8BFFFFFF); 

//assign Valid = (Htrans == SEQ) || (Htrans == NONSEQ) && (Haddr >= 32'h80000000) && (Haddr <= 32'h8bffffff) && Hreadyin;

always@ (*)
	begin
	if ((Htrans == `SEQ) || (Htrans == `NONSEQ) && (Haddr >= 32'h80000000) && (Haddr <= 32'h8bffffff) && Hreadyin)
	Valid <= 1;
	else if (!Hreset)
	Valid <= 0;
	end

/*Hrdata <= Hdata2;
	//assign Hdata_1 <= 
	end

Hready = 1 // transfer complete
else #Hclk// transfer extended max 16 wait cycles


Hwrite = 1 
Hwdata // data from master to slave
else Hrdata // data from slave to master*/

endmodule
