	.text
    .org 0x0000

	ADD x2, x0, x0 	// x2 = 0
	ADD x3, x0, x0 	// x3 = 0
loop1:					// loop1:
	CBZ x30, end1		// if x30 == 0, goto end1
	STUR x3, [x2, #0]	// [x2] = x3
	ADD x3, x3, x1		// x3 = x3 + x1
	SUB x30, x30, x1	// x30 = x30 - x1
	ADD x2, x2, x8		// x2 = x2 + x8
	CBZ x0, loop1		// if x0 == 0, goto loop1
end1:

	ADD x2, x0, x0
	ADD x4, x0, x0
loop2:
	CBZ x17, end2		
	ADD x4, x4, x16
	SUB x17, x17, x1
	CBZ x0, loop2
end2:
	STUR x4, [x2, #0]

infloop:
	CBZ x0, infloop

/* 
x16 * x17
ROM [0:15] ='{32'h8b000002,
32'h8b000003,
32'hb40000de,
32'hf8000043,
32'h8b010063,
32'hcb0103de,
32'h8b080042,
32'hb4ffff60,
32'h8b000002,
32'h8b000004,
32'hb4000091,
32'h8b100084,
32'hcb010231,
32'hb4ffffa0,
32'hf8000044,
32'hb4000000};
*/