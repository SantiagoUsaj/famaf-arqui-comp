	.text
	.org 0x0000
	
	ADD x2, xzr, xzr 	// x2 = 0
loop:					// loop:
	SUB x3, x0, x30		// x3 = x0 - x30
	CBZ x3, end			// if x3 == 0, goto end
	STUR x0, [x2, #0]	// [x2] = x0
	ADD x0, x1, x0		// x0 = x1 + x0
	ADD x2, x2, x8		// x2 = x2 + x8
	CBZ xzr, loop		// if xzr == 0, goto loop
end:

infloop:
	CBZ xzr, infloop

