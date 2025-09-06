	.text
	.org 0x0000
	
	ADD x2, x0, x0 	// x2 = 0
	ADD x3, x0, x0 	// x3 = 0
loop:					// loop:
	CBZ x30, end		// if x30 == 0, goto end
	STUR x3, [x2, #0]	// [x2] = x3
	ADD x3, x3, x1		// x3 = x3 + x1
	SUB x30, x30, x1	// x30 = x30 - x1
	ADD x2, x2, x8		// x2 = x2 + x8
	CBZ x0, loop		// if x0 == 0, goto loop
end:

infloop:	
	CBZ x0, infloop

/* 
N = 29
ROM [0:8] ='{32'h8b000002,
32'h8b000003,
32'hb40000de,
32'hf8000043,
32'h8b010063,
32'hcb0103de,
32'h8b080042,
32'hb4ffff60,
32'hb4000000};
*/