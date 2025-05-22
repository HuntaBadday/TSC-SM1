; SM1 assembly definitions
; HuntaBadday

#subruledef reg {
	r0	=> 1`4
	r1	=> 2`4
	r2	=> 3`4
	r3	=> 4`4
	r4	=> 5`4
	r5	=> 6`4
	r6	=> 7`4
	r7	=> 8`4
	r8	=> 9`4
	r9	=> 10`4
	r10 => 11`4
	r11	=> 12`4
	r12	=> 13`4
	sp	=> 14`4
	st	=> 15`4
}

#ruledef {
	brk =>  0x0000
	jmp	{op1: reg}	=> 0b0001 @ op1 @ 0b00001000
	jmp	{addr: u16}	=> 0b0001000000001000 @ addr
	
	mov	{op1: reg}, {op2: reg}	=> 0b0010 @ op1 @ op2 @ 0b0000
	mov	{op1: reg}, {imm: i16}	=> 0b0010 @ op1 @ 0b00000000 @ imm
	
	lod	{op1: reg}, {op2: reg}	=> 0b0011 @ op1 @ op2 @ 0b0000
	lod	{op1: reg}, {addr: u16}	=> 0b0011 @ op1 @ 0b00000000 @ addr
	lod {op1: reg}, {op2: reg}+{op3: reg}	=> 0b0011 @ op1 @ op2 @ op3
	lod {op1: reg}, {op3: reg}+{offst: i16}	=> 0b0011 @ op1 @ 0b0000 @ op3 @ offst
	lod {op1: reg}, {offst: i16}+{op3: reg}	=> 0b0011 @ op1 @ 0b0000 @ op3 @ offst
	
	sto	{op1: reg}, {op2: reg}	=> 0b0100 @ op1 @ op2 @ 0b0000
	sto	{op1: reg}, {addr: u16}	=> 0b0100 @ op1 @ 0b00000000 @ addr
	sto {op1: reg}, {op2: reg}+{op3: reg}	=> 0b0100 @ op1 @ op2 @ op3
	sto	{op1: reg}, {op3: reg}+{offst: i16}	=> 0b0100 @ op1 @ 0b0000 @ op3 @ offst
	sto {op1: reg}, {offst: i16}+{op3: reg}	=> 0b0100 @ op1 @ 0b0000 @ op3 @ offst
	;-------------------
	
	mov	{op1: reg}, [{op2: reg}]	=> 0b0011 @ op1 @ op2 @ 0b0000
	mov	{op1: reg}, [{addr: u16}]	=> 0b0011 @ op1 @ 0b00000000 @ addr
	mov {op1: reg}, [{op2: reg}+{op3: reg}]	=> 0b0011 @ op1 @ op2 @ op3
	mov {op1: reg}, [{op3: reg}+{offst: i16}]	=> 0b0011 @ op1 @ 0b0000 @ op3 @ offst
	mov {op1: reg}, [{offst: i16}+{op3: reg}]	=> 0b0011 @ op1 @ 0b0000 @ op3 @ offst
	
	mov	[{op2: reg}], {op1: reg}	=> 0b0100 @ op1 @ op2 @ 0b0000
	mov	[{addr: u16}], {op1: reg}	=> 0b0100 @ op1 @ 0b00000000 @ addr
	mov [{op2: reg}+{op3: reg}], {op1: reg}	=> 0b0100 @ op1 @ op2 @ op3
	mov	[{op3: reg}+{offst: i16}], {op1: reg}	=> 0b0100 @ op1 @ 0b0000 @ op3 @ offst
	mov	[{op3: reg}-{offst: i16}], {op1: reg}	=> 0b0100 @ op1 @ 0b0000 @ op3 @ offst
	mov [{offst: i16}+{op3: reg}], {op1: reg} 	=> 0b0100 @ op1 @ 0b0000 @ op3 @ offst
	
	;-------------------
	add {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b0000
	add {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00000000 @ imm
	add {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b0000 @ imm
	
	adc {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b0001
	adc {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00000001 @ imm
	adc {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b0001 @ imm
	
	sub {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b0010
	sub {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00000010 @ imm
	sub {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b0010 @ imm
	
	sbc {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b0011
	sbc {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00000011 @ imm
	sbc {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b0011 @ imm
	
	shl {op1: reg}	=> 0b0101 @ op1 @ 0b11110100
	rol {op1: reg}	=> 0b0101 @ op1 @ 0b11110101
	shr {op1: reg}	=> 0b0101 @ op1 @ 0b11110110
	ror {op1: reg}	=> 0b0101 @ op1 @ 0b11110111
	
	and {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b1000
	and {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00001000 @ imm
	and {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b1000 @ imm
	
	or {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b1001
	or {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00001001 @ imm
	or {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b1001 @ imm
	
	xor {op1: reg}, {op2: reg}	=> 0b0101 @ op1 @ op2 @ 0b1010
	xor {op1: reg}, {imm: i16}	=> 0b0101 @ op1 @ 0b00001010 @ imm
	xor {imm: i16}, {op2: reg}	=> 0b01010000 @ op2 @ 0b1010 @ imm
	
	neg {op1: reg}	=>	0b0101 @ op1 @ 0b00001111
	
	;-------------------
	
	adds {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b0000
	adds {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00000000 @ imm
	adds {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b0000 @ imm
	
	adcs {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b0001
	adcs {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00000001 @ imm
	adcs {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b0001 @ imm
	
	subs {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b0010
	subs {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00000010 @ imm
	subs {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b0010 @ imm
	
	sbcs {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b0011
	sbcs {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00000011 @ imm
	sbcs {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b0011 @ imm
	
	shls {op1: reg}	=> 0b0110 @ op1 @ 0b11110100
	rols {op1: reg}	=> 0b0110 @ op1 @ 0b11110101
	shrs {op1: reg}	=> 0b0110 @ op1 @ 0b11110110
	rors {op1: reg}	=> 0b0110 @ op1 @ 0b11110111
	
	ands {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b1000
	ands {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00001000 @ imm
	ands {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b1000 @ imm
	
	ors {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b1001
	ors {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00001001 @ imm
	ors {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b1001 @ imm
	
	xors {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b1010
	xors {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00001010 @ imm
	xors {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b1010 @ imm
	
	cmp {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b0010
	cmp {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00000010 @ imm
	cmp {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b0010 @ imm
	
	bit {op1: reg}, {op2: reg}	=> 0b0110 @ op1 @ op2 @ 0b1000
	bit {op1: reg}, {imm: i16}	=> 0b0110 @ op1 @ 0b00001000 @ imm
	bit {imm: i16}, {op2: reg}	=> 0b01100000 @ op2 @ 0b1000 @ imm
	
	;-------------------
	
	bcs {op1: reg}	=> 0b0001 @ op1 @ 0b00000001
	bcs {addr: u16}	=> 0b0001 @ 0b000000000001 @ addr
	
	beq {op1: reg}	=> 0b0001 @ op1 @ 0b00000010
	beq {addr: u16}	=> 0b0001 @ 0b000000000010 @ addr
	
	bmi {op1: reg}	=> 0b0001 @ op1 @ 0b00000100
	bmi {addr: u16}	=> 0b0001 @ 0b000000000100 @ addr
	
	bcc {op1: reg}	=> 0b0001 @ op1 @ 0b00001001
	bcc {addr: u16}	=> 0b0001 @ 0b000000001001 @ addr
	
	bne {op1: reg}	=> 0b0001 @ op1 @ 0b00001010
	bne {addr: u16}	=> 0b0001 @ 0b000000001010 @ addr
	
	bpl {op1: reg}	=> 0b0001 @ op1 @ 0b00001100
	bpl {addr: u16}	=> 0b0001 @ 0b000000001100 @ addr
	
	;-------------------
	
	bxa {op1: reg}	=> 0b0001 @ op1 @ 0b00010000
	bxa {addr: u16}	=> 0b0001 @ 0b000000010000 @ addr
	
	bna {op1: reg}	=> 0b0001 @ op1 @ 0b00011000
	bna {addr: u16}	=> 0b0001 @ 0b000000011000 @ addr
	
	bxb {op1: reg}	=> 0b0001 @ op1 @ 0b00100000
	bxb {addr: u16}	=> 0b0001 @ 0b000000100000 @ addr
	
	bnb {op1: reg}	=> 0b0001 @ op1 @ 0b00101000
	bnb {addr: u16}	=> 0b0001 @ 0b000000101000 @ addr
	
	bxc {op1: reg}	=> 0b0001 @ op1 @ 0b01000000
	bxc {addr: u16}	=> 0b0001 @ 0b000001000000 @ addr
	
	bnc {op1: reg}	=> 0b0001 @ op1 @ 0b01001000
	bnc {addr: u16}	=> 0b0001 @ 0b000001001000 @ addr
	
	bxd {op1: reg}	=> 0b0001 @ op1 @ 0b10000000
	bxd {addr: u16}	=> 0b0001 @ 0b000010000000 @ addr
	
	bnd {op1: reg}	=> 0b0001 @ op1 @ 0b10001000
	bnd {addr: u16}	=> 0b0001 @ 0b000010001000 @ addr
	
	;-------------------
	
	nop	=> 0b1000 @ 0b000000000000
	
	int	{op1: reg}	=> 0b1001 @ op1 @ 0b00000000
	int	{addr: u16}	=> 0b1001 @ 0b000000000000 @ addr
	
	push {op1: reg}	=> 0b1011 @ op1 @ 0b00000000
	push {imm: i16}	=> 0b1011000000000000 @ imm
	
	pop {op1: reg}	=> 0b1100 @ op1 @ 0b00000000
	
	jsr {op1: reg}	=> 0b1101 @ op1 @ 0b00000000
	jsr {addr: u16}	=> 0b1101 @ 0b000000000000 @ addr
	
	rts	=> 0b1110000000000000
	rti	=> 0b1111000000000000
}

#ruledef {
	pushall	=>	asm{
		push st
		push r0
		push r1
		push r2
		push r3
		push r4
		push r5
		push r6
		push r7
		push r8
		push r9
		push r10
		push r11
		push r12
	}
	
	popall	=>	asm{
		pop r12
		pop r11
		pop r10
		pop r9
		pop r8
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		plp
	}
	
	clc => asm {
		and st, 0b1111111111111110
	}
	sec => asm {
		or st, 0b0001
	}
	
	clz => asm {
		and st, 0b1111111111111101
	}
	sez => asm {
		or st, 0b0010
	}
	
	cln => asm {
		and st, 0b1111111111111011
	}
	sen => asm {
		or st, 0b0100
	}
	
	cli => asm {
		and st, 0b1111111111110111
	}
	sei => asm {
		or st, 0b1000
	}
	
	clxa => asm {
		and st, 0b1111111011111111
	}
	sexa => asm {
		or st, 0b0000000100000000
	}
	
	clxb => asm {
		and st, 0b1111110111111111
	}
	sexb => asm {
		or st, 0b0000001000000000
	}
	
	clxc => asm {
		and st, 0b1111101111111111
	}
	sexc => asm {
		or st, 0b0000010000000000
	}
	
	clxd => asm {
		and st, 0b1111011111111111
	}
	sexd => asm {
		or st, 0b0000100000000000
	}
	
	pause => asm {
		clc
		bcc $
	}
}