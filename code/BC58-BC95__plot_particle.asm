; --- plot_particle -------------------------------------------
; @done
; XOR-plot one particle pixel at screen coords (d = y, e = x),
; using PARTICLE_TRACES for the pixel mask. Skips y >= $90.
plot_particle:
	ld a, d

	cp $90
	ret nc

	push hl
	ld hl, PARTICLE_TRACES
	ld a, e
	and $07
	add a, l
	ld l, a
	jr nc, .plot

	inc h
.plot:
	ld a, (hl)
	ld (.mask+1), a		; set SMC
	ld a, e
	rrca
	rrca
	rrca
	and $1F
	ld l, a
	ld a, d
	rlca
	rlca
	and $E0
	or l
	ld l, a
	ld a, d
	and $07
	ld h, a
	ld a, d
	rrca
	rrca
	rrca
	and $18
	or h
	or $40
	ld h, a

.mask:
	ld a, $00		; !!! SMC

	xor (hl)
	ld (hl), a
	pop hl

	ret


; single-set-bit pixel masks (bit 7..0); plot_particle uses [x & 7] to XOR one pixel.
PARTICLE_TRACES:
	DB $80,$40,$20,$10,$08,$04,$02,$01
