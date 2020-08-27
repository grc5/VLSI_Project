//Htrans
`define IDLE 2'b00
`define BUSY 2'b01
`define NONSEQ 2'b10
`define SEQ 2'b11

//Hburst type
`define SINGLE 3'b000
`define INCR 3'b001
`define WRAP4 3'b010
`define INCR4 3'b011
`define WRAP8 3'b100
`define INCR8 3'b101
`define WRAP16 3'b110
`define INCR16 3'b111

//Hresp : response signals
`define OKAY 2'b00
`define ERROR 2'b01
`define RETRY 2'b10
`define SPLIT 2'b11

//FSM state
`define ST_IDLE 3'b000
`define ST_WWAIT 3'b001
`define ST_READ 3'b010
`define ST_WRITE 3'b011
`define ST_WRITEP 3'b100
`define ST_RENABLE 3'b101
`define ST_WENABLE 3'b110
`define ST_WENABLEP 3'b111

//Hsize
`define BYTE 3'b000
`define HALFWORD 3'b001
`define WORD 3'b010
