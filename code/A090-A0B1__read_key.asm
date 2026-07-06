; --- read_key -------------------------------------------------
; @done
; Test whether a single ZX keyboard key is currently pressed.
; The key is given as a packed matrix code: bits 4-6 pick the
; half-row (the address line pulled low), bits 0-2 pick the
; column bit within that half-row. The row-select and bit-test
; instructions are built by self-modifying code, then the ULA
; keyboard port is read once.
; In:  a = packed key code, (half_row << 4) | column_bit
; Out: zf set   = key pressed (matrix bit reads 0)
;      zf clear = key released
; Note: self-modifies the `res n,b` / `bit m,c` operands below.
read_key:
	push bc
	push af
	ld b, a
	rrca
	and $38
	or $80
	ld (.sel_row+1), a	; patch `res n,b`: select half-row
	ld a, b
	rlca
	rlca
	rlca
	and $38
	or $41
	ld (.test_bit+1), a	; patch `bit m,c`: select column bit
	ld bc, IS_128K		; b=$FF row mask, c=$FE ULA keyboard port

.sel_row:
	res 0, b		; !!! SMC: res <half_row>, b
	in c, (c)		; read keyboard half-row into c
	pop af

.test_bit:
	bit 0, c		; !!! SMC: bit <column>, c -> zf = pressed
	pop bc

	ret
