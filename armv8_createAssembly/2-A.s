	.text
	.org 0x0000
	
	ADD x2, xzr, xzr 	// x2 = 0
loop:					// loop:
	SUB x3, x30, x0		// x3 = x30 - x0
	CBZ x3, end			// if x3 == 0, goto end
	STUR x0, [x2, #0]	// [x2] = x0
	ADD x0, x1, x0		// x0 = x1 + x0
	ADD x2, x2, x8		// x2 = x2 + x8
	CBZ xzr, loop		// if xzr == 0, goto loop
end:

infloop:
	CBZ xzr, infloop

/* 
ROM [0:7] ='{32'h8b1f03e2,
32'hcb1e0003,
32'hb40000a3,
32'hf8000040,
32'h8b000020,
32'h8b080042,
32'hb4ffff7f,
32'hb400001f}; 
*/