LA090:
	push bc
	push af
	ld b, a
	rrca
	and $38
	or $80
	ld (LA0A9+1), a     ; set SMC
	ld a, b
	rlca
	rlca
	rlca
	and $38
	or $41
	ld (LA0AE+1), a     ; set SMC
	ld bc, LFFFE

LA0A9:
	res 0, b		; !!! SMC
	in c, (c)
	pop af

LA0AE:
	bit 0, c		; !!! SMC
	pop bc

	ret
